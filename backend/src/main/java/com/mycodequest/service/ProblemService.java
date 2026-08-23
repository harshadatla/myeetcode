package com.mycodequest.service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.mycodequest.dto.problem.HintDto;
import com.mycodequest.dto.problem.ProblemDetailDto;
import com.mycodequest.dto.problem.ProblemDto;
import com.mycodequest.dto.problem.TestCaseDto;
import com.mycodequest.entity.Hint;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.SkillTreeProgress;
import com.mycodequest.entity.TestCase;
import com.mycodequest.exception.NotFoundException;
import com.mycodequest.repository.HintRepository;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.repository.SkillTreeProgressRepository;
import com.mycodequest.repository.TestCaseRepository;

@Service
public class ProblemService {

    private final ProblemRepository problemRepo;
    private final TestCaseRepository testCaseRepo;
    private final HintRepository hintRepo;
    private final SkillTreeProgressRepository skillTreeRepo;

    public ProblemService(ProblemRepository problemRepo,
                          TestCaseRepository testCaseRepo,
                          HintRepository hintRepo,
                          SkillTreeProgressRepository skillTreeRepo) {
        this.problemRepo = problemRepo;
        this.testCaseRepo = testCaseRepo;
        this.hintRepo = hintRepo;
        this.skillTreeRepo = skillTreeRepo;
    }

    public List<ProblemDto> getAllProblems(Long userId) {
        List<Problem> problems = problemRepo.findAllByOrderByRealmIdAscOrderInRealmAsc();
        List<SkillTreeProgress> progress = skillTreeRepo.findByUserId(userId);
        Set<Long> completedIds = progress.stream()
                .filter(SkillTreeProgress::getIsCompleted)
                .map(SkillTreeProgress::getProblemId)
                .collect(Collectors.toSet());
        Set<Long> unlockedIds = progress.stream()
                .filter(SkillTreeProgress::getIsUnlocked)
                .map(SkillTreeProgress::getProblemId)
                .collect(Collectors.toSet());

        return problems.stream().map(p -> new ProblemDto(
                p.getId(),
                p.getRealmId(),
                p.getSlug(),
                p.getTitle(),
                p.getDifficulty(),
                p.getXpReward(),
                p.getOrderInRealm(),
                p.getIsBoss() != null && p.getIsBoss(),
                completedIds.contains(p.getId()),
                unlockedIds.contains(p.getId())
        )).toList();
    }

    public ProblemDetailDto getProblem(String slug, Long userId) {
        Problem problem = problemRepo.findBySlug(slug)
                .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));

        List<TestCase> sampleTests = testCaseRepo.findByProblemIdAndIsHiddenFalseOrderByOrderNum(problem.getId());
        List<TestCaseDto> sampleTestDtos = sampleTests.stream()
                .map(tc -> new TestCaseDto(tc.getInput(), tc.getExpectedOutput(), false))
                .toList();

        List<Hint> hints = hintRepo.findByProblemIdOrderByLayer(problem.getId());
        // For problem detail, show hint metadata but not content (locked by default)
        List<HintDto> hintDtos = hints.stream()
                .map(h -> new HintDto(h.getLayer(), h.getName(), h.getIcon(), null, h.getHpCost(), false, "STATIC"))
                .toList();

        return new ProblemDetailDto(
                problem.getId(),
                problem.getRealmId(),
                problem.getSlug(),
                problem.getTitle(),
                problem.getDescription(),
                problem.getDifficulty(),
                problem.getXpReward(),
                problem.getStarterCode(),
                sampleTestDtos,
                hintDtos,
                problem.getIsBoss() != null && problem.getIsBoss(),
                problem.getTimeLimitMs() != null ? problem.getTimeLimitMs() : 2000,
                problem.getMemoryLimitKb() != null ? problem.getMemoryLimitKb() : 256000
        );
    }

    public List<TestCaseDto> getTestCases(String slug, Long userId) {
        Problem problem = problemRepo.findBySlug(slug)
                .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
        List<TestCase> sampleTests = testCaseRepo.findByProblemIdAndIsHiddenFalseOrderByOrderNum(problem.getId());
        return sampleTests.stream()
                .map(tc -> new TestCaseDto(tc.getInput(), tc.getExpectedOutput(), false))
                .toList();
    }

    public Problem getBySlug(String slug) {
        return problemRepo.findBySlug(slug)
                .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
    }

    public Problem getById(Long id) {
        return problemRepo.findById(id)
                .orElseThrow(() -> new NotFoundException("Problem not found: " + id));
    }
}