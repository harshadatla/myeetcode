package com.mycodequest.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycodequest.dto.submission.Judge0Response;
import com.mycodequest.dto.submission.SubmissionDto;
import com.mycodequest.dto.submission.SubmissionResultDto;
import com.mycodequest.dto.submission.SubmitRequest;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.Submission;
import com.mycodequest.entity.TestCase;
import com.mycodequest.entity.User;
import com.mycodequest.exception.NotFoundException;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.repository.SubmissionRepository;
import com.mycodequest.repository.TestCaseRepository;
import com.mycodequest.repository.UserRepository;

@Service
public class SubmissionService {

    private final ProblemRepository problemRepo;
    private final TestCaseRepository testCaseRepo;
    private final SubmissionRepository submissionRepo;
    private final UserRepository userRepo;
    private final Judge0Client judge0Client;
    private final ProgressService progressService;
    private final SkillTreeService skillTreeService;
    private final AchievementService achievementService;

    public SubmissionService(ProblemRepository problemRepo,
                             TestCaseRepository testCaseRepo,
                             SubmissionRepository submissionRepo,
                             UserRepository userRepo,
                             Judge0Client judge0Client,
                             ProgressService progressService,
                             SkillTreeService skillTreeService,
                             AchievementService achievementService) {
        this.problemRepo = problemRepo;
        this.testCaseRepo = testCaseRepo;
        this.submissionRepo = submissionRepo;
        this.userRepo = userRepo;
        this.judge0Client = judge0Client;
        this.progressService = progressService;
        this.skillTreeService = skillTreeService;
        this.achievementService = achievementService;
    }

    @Transactional
    public SubmissionResultDto submit(Long userId, SubmitRequest req) {
        Problem problem = problemRepo.findBySlug(req.slug())
                .orElseThrow(() -> new NotFoundException("Problem not found: " + req.slug()));

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new NotFoundException("User not found: " + userId));

        // Get test cases: sample only for runSampleOnly, all for full submit
        List<TestCase> testCases;
        if (req.runSampleOnly()) {
            testCases = testCaseRepo.findByProblemIdAndIsHiddenFalseOrderByOrderNum(problem.getId());
        } else {
            testCases = testCaseRepo.findByProblemIdOrderByOrderNum(problem.getId());
        }

        if (testCases.isEmpty()) {
            testCases = testCaseRepo.findByProblemIdAndIsHiddenFalseOrderByOrderNum(problem.getId());
        }

        double timeLimit = (problem.getTimeLimitMs() != null ? problem.getTimeLimitMs() : 2000) / 1000.0;
        int memoryLimit = problem.getMemoryLimitKb() != null ? problem.getMemoryLimitKb() : 256000;

        // Run each test case through Judge0
        List<SubmissionResultDto.TestCaseResultDto> results = new ArrayList<>();
        int passedCount = 0;
        boolean compileError = false;
        String compileOutput = null;
        String firstErrorStatus = null;

        for (int i = 0; i < testCases.size(); i++) {
            TestCase tc = testCases.get(i);
            Judge0Response judge0Response;
            try {
                judge0Response = judge0Client.submitAndPoll(
                        req.sourceCode(),
                        tc.getInput(),
                        tc.getExpectedOutput(),
                        timeLimit,
                        memoryLimit
                );
            } catch (Exception e) {
                // Judge0 error — mark as runtime error
                results.add(new SubmissionResultDto.TestCaseResultDto(
                        i + 1,
                        "RUNTIME_ERROR",
                        tc.getInput(),
                        tc.getExpectedOutput(),
                        "Judge0 error: " + e.getMessage(),
                        0,
                        0
                ));
                if (firstErrorStatus == null) firstErrorStatus = "RUNTIME_ERROR";
                continue;
            }

            int statusId = judge0Response.status().id();
            String status = mapJudge0Status(statusId);
            String actualOutput = judge0Response.stdout() != null ? judge0Response.stdout() : "";
            int timeMs = judge0Response.time() != null
                    ? (int) Double.parseDouble(judge0Response.time()) * 1000
                    : 0;
            int memoryKb = judge0Response.memory() != null ? judge0Response.memory() : 0;

            // Check if the output matches (trimmed comparison)
            boolean passed = false;
            if (statusId == 3) { // Accepted by Judge0
                String expected = tc.getExpectedOutput() != null ? tc.getExpectedOutput().trim() : "";
                String actual = actualOutput.trim();
                passed = expected.equals(actual);
                if (!passed) {
                    status = "WRONG_ANSWER";
                }
            }

            if (passed) {
                passedCount++;
            } else {
                if (firstErrorStatus == null) {
                    firstErrorStatus = status;
                }
                if (statusId == 6) {
                    compileError = true;
                    compileOutput = judge0Response.compileOutput();
                }
            }

            results.add(new SubmissionResultDto.TestCaseResultDto(
                    i + 1,
                    status,
                    tc.getInput(),
                    tc.getExpectedOutput(),
                    actualOutput,
                    timeMs,
                    memoryKb
            ));
        }

        int totalCount = testCases.size();
        boolean allPassed = passedCount == totalCount && totalCount > 0;

        // Determine overall status
        String overallStatus;
        if (compileError) {
            overallStatus = "COMPILE_ERROR";
        } else if (allPassed) {
            overallStatus = "ACCEPTED";
        } else {
            overallStatus = firstErrorStatus != null ? firstErrorStatus : "WRONG_ANSWER";
        }

        // Save the submission record
        Submission submission = new Submission();
        submission.setUserId(userId);
        submission.setProblemId(problem.getId());
        submission.setSourceCode(req.sourceCode());
        submission.setStatus(overallStatus);
        // Store the first test case's output for display
        if (!results.isEmpty()) {
            submission.setStdout(results.get(0).actualOutput());
        }
        if (compileError && compileOutput != null) {
            submission.setCompileOutput(compileOutput);
        }
        // Store error output if any
        if (!results.isEmpty() && results.get(0).status() != null && !"ACCEPTED".equals(results.get(0).status())) {
            // Already set above
        }
        submission.setExecutionTimeMs(results.isEmpty() ? 0 : results.get(0).timeMs());
        submission.setMemoryUsedKb(results.isEmpty() ? 0 : results.get(0).memoryKb());
        submissionRepo.save(submission);

        // RPG progression: only on full submit (not sample run)
        int xpGained = 0;
        int newTotalXp = user.getXp();
        int newLevel = user.getLevel();
        boolean leveledUp = false;
        int hpRemaining = user.getHp();
        List<String> newAchievements = new ArrayList<>();
        boolean bossDefeated = false;

        if (!req.runSampleOnly()) {
            if (allPassed) {
                // Only award XP if this is the first time completing this problem
                boolean alreadyCompleted = skillTreeService.isCompleted(userId, problem.getId());
                if (!alreadyCompleted) {
                    // Award XP with streak multiplier
                    int baseXp = problem.getXpReward() != null ? problem.getXpReward() : 50;
                    // Update streak first so multiplier applies
                    progressService.updateStreak(user);
                    xpGained = progressService.applyXpWithStreak(user, baseXp);
                    newTotalXp = user.getXp();
                    int oldLevel = newLevel;
                    newLevel = user.getLevel();
                    leveledUp = newLevel > oldLevel;

                    // Update skill tree
                    skillTreeService.onProblemCompleted(userId, problem.getId());

                    // Check if boss defeated
                    if (problem.getIsBoss() != null && problem.getIsBoss()) {
                        bossDefeated = true;
                    }

                    // Check achievements
                    newAchievements = achievementService.checkAchievements(userId, user, problem, submission);

                    // Check realm conqueror
                    if (bossDefeated) {
                        List<String> realmAchievements = achievementService.checkRealmConqueror(userId, problem.getRealmId());
                        newAchievements.addAll(realmAchievements);
                    }
                } else {
                    // Already completed — no XP but still count as accepted
                    progressService.updateStreak(user);
                }
            } else {
                // Wrong submission — deduct HP
                hpRemaining = progressService.deductHp(user, 10);
            }
            userRepo.save(user);
        }

        return new SubmissionResultDto(
                overallStatus,
                passedCount,
                totalCount,
                results,
                xpGained,
                newTotalXp,
                newLevel,
                leveledUp,
                hpRemaining,
                newAchievements,
                bossDefeated
        );
    }

    public SubmissionDto getSubmission(Long id, Long userId) {
        Submission sub = submissionRepo.findById(id)
                .orElseThrow(() -> new NotFoundException("Submission not found: " + id));
        if (!sub.getUserId().equals(userId)) {
            throw new NotFoundException("Submission not found: " + id);
        }
        return new SubmissionDto(
                sub.getId(),
                sub.getProblemId(),
                sub.getStatus(),
                sub.getSourceCode(),
                sub.getExecutionTimeMs(),
                sub.getMemoryUsedKb(),
                sub.getCreatedAt()
        );
    }

    public List<SubmissionDto> getHistory(Long userId, Long problemId) {
        List<Submission> subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problemId);
        return subs.stream().map(s -> new SubmissionDto(
                s.getId(),
                s.getProblemId(),
                s.getStatus(),
                s.getSourceCode(),
                s.getExecutionTimeMs(),
                s.getMemoryUsedKb(),
                s.getCreatedAt()
        )).toList();
    }

    private String mapJudge0Status(int statusId) {
        return switch (statusId) {
            case 3 -> "ACCEPTED";
            case 4 -> "WRONG_ANSWER";
            case 5 -> "TIME_LIMIT_EXCEEDED";
            case 6 -> "COMPILE_ERROR";
            case 7, 8, 9, 10, 11, 12, 13, 14 -> "RUNTIME_ERROR";
            default -> "UNKNOWN";
        };
    }
}