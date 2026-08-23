package com.mycodequest.service;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycodequest.dto.problem.DynamicHintDto;
import com.mycodequest.dto.problem.HintDto;
import com.mycodequest.dto.problem.HintStateDto;
import com.mycodequest.dto.problem.PatternHintDto;
import com.mycodequest.entity.Hint;
import com.mycodequest.entity.HintUsage;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.Submission;
import com.mycodequest.entity.User;
import com.mycodequest.exception.NotFoundException;
import com.mycodequest.repository.*;

@Service
public class HintService {

    private final HintRepository hintRepo;
    private final HintUsageRepository hintUsageRepo;
    private final SubmissionRepository submissionRepo;
    private final ProblemRepository problemRepo;
    private final ProblemPatternRepository patternRepo;
    private final UserRepository userRepo;
    private final HintEngine hintEngine;

    public HintService(HintRepository hintRepo, HintUsageRepository hintUsageRepo,
                       SubmissionRepository submissionRepo, ProblemRepository problemRepo,
                       ProblemPatternRepository patternRepo, UserRepository userRepo,
                       HintEngine hintEngine) {
        this.hintRepo = hintRepo;
        this.hintUsageRepo = hintUsageRepo;
        this.submissionRepo = submissionRepo;
        this.problemRepo = problemRepo;
        this.patternRepo = patternRepo;
        this.userRepo = userRepo;
        this.hintEngine = hintEngine;
    }

    public HintStateDto getHintState(Long userId, Long problemId) {
        List<Hint> allHints = hintRepo.findByProblemIdOrderByLayer(problemId);
        List<HintUsage> usedHints = hintUsageRepo.findByUserIdAndProblemId(userId, problemId);

        Set<Integer> unlockedLayers = usedHints.stream()
            .filter(h -> "STATIC".equals(h.getHintType()))
            .map(HintUsage::getHintLayer)
            .collect(Collectors.toSet());

        List<HintDto> hintDtos = allHints.stream().map(h -> new HintDto(
            h.getLayer(), h.getName(), h.getIcon(),
            unlockedLayers.contains(h.getLayer()) ? h.getContent() : null,
            h.getHpCost(), unlockedLayers.contains(h.getLayer()), "STATIC"
        )).toList();

        Optional<Submission> lastFailed = submissionRepo
            .findFirstByUserIdAndProblemIdAndStatusNotOrderByCreatedAtDesc(userId, problemId, "ACCEPTED");
        boolean dynamicAvailable = lastFailed.isPresent();
        String lastFailureType = lastFailed.map(Submission::getStatus).orElse(null);

        int totalHpSpent = usedHints.stream().mapToInt(HintUsage::getHpCost).sum();

        List<PatternHintDto> patternHints = findPatternHints(userId, problemId);

        return new HintStateDto(hintDtos, dynamicAvailable, lastFailureType,
                totalHpSpent, usedHints.size(), patternHints);
    }

    @Transactional
    public HintDto unlockStaticHint(Long userId, Long problemId, int layer) {
        // Validate sequential unlock
        if (layer > 1) {
            List<HintUsage> used = hintUsageRepo.findByUserIdAndProblemId(userId, problemId);
            boolean previousUnlocked = used.stream()
                .anyMatch(h -> "STATIC".equals(h.getHintType()) && h.getHintLayer() == layer - 1);
            if (!previousUnlocked) {
                throw new IllegalArgumentException(
                    "You must unlock Layer " + (layer - 1) + " first. Hints unlock progressively.");
            }
        }

        // Check if already unlocked
        List<HintUsage> existing = hintUsageRepo.findByUserIdAndProblemId(userId, problemId);
        for (HintUsage u : existing) {
            if ("STATIC".equals(u.getHintType()) && u.getHintLayer() == layer) {
                Hint hint = hintRepo.findByProblemIdAndLayer(problemId, layer).orElseThrow();
                return new HintDto(hint.getLayer(), hint.getName(), hint.getIcon(),
                    hint.getContent(), hint.getHpCost(), true, "STATIC");
            }
        }

        Hint hint = hintRepo.findByProblemIdAndLayer(problemId, layer)
            .orElseThrow(() -> new NotFoundException("Hint layer " + layer + " not found for this problem"));

        User user = userRepo.findById(userId)
            .orElseThrow(() -> new NotFoundException("User not found"));
        if (user.getHp() < hint.getHpCost()) {
            throw new IllegalArgumentException(
                "Not enough HP! You have " + user.getHp() + " HP, but this hint costs " + hint.getHpCost() + " HP.");
        }
        user.setHp(user.getHp() - hint.getHpCost());
        userRepo.save(user);

        HintUsage usage = new HintUsage();
        usage.setUserId(userId);
        usage.setProblemId(problemId);
        usage.setHintLayer(layer);
        usage.setHintType("STATIC");
        usage.setHpCost(hint.getHpCost());
        usage.setContent(hint.getContent());
        hintUsageRepo.save(usage);

        return new HintDto(hint.getLayer(), hint.getName(), hint.getIcon(),
            hint.getContent(), hint.getHpCost(), true, "STATIC");
    }

    @Transactional
    public DynamicHintDto getDynamicHint(Long userId, Long problemId) {
        Optional<Submission> lastFailed = submissionRepo
            .findFirstByUserIdAndProblemIdAndStatusNotOrderByCreatedAtDesc(userId, problemId, "ACCEPTED");
        if (lastFailed.isEmpty()) {
            throw new IllegalArgumentException(
                "Dynamic hints require at least one failed submission. Submit your code first!");
        }

        User user = userRepo.findById(userId)
            .orElseThrow(() -> new NotFoundException("User not found"));
        if (user.getHp() < 10) {
            throw new IllegalArgumentException(
                "Not enough HP! Dynamic hints cost 10 HP. You have " + user.getHp() + " HP.");
        }
        user.setHp(user.getHp() - 10);
        userRepo.save(user);

        Problem problem = problemRepo.findById(problemId)
            .orElseThrow(() -> new NotFoundException("Problem not found"));

        List<com.mycodequest.entity.TestCase> testCases = List.of();
        DynamicHintDto hint = hintEngine.generateHint(lastFailed.get(), problem, testCases);

        HintUsage usage = new HintUsage();
        usage.setUserId(userId);
        usage.setProblemId(problemId);
        usage.setHintLayer(0);
        usage.setHintType(hint.hintType());
        usage.setHpCost(10);
        usage.setContent(hint.content());
        hintUsageRepo.save(usage);

        return hint;
    }

    private List<PatternHintDto> findPatternHints(Long userId, Long problemId) {
        // Find patterns for the current problem
        List<com.mycodequest.entity.ProblemPattern> currentPatterns = patternRepo.findByProblemId(problemId);

        // Find problems the user has solved (ACCEPTED submissions)
        List<Submission> accepted = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problemId);

        // Simple pattern matching: if current problem has patterns, check if user has solved
        // other problems with the same pattern
        // For now, return empty — full pattern matching needs cross-problem query
        return List.of();
    }
}