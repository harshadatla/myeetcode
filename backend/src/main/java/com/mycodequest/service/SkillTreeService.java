package com.mycodequest.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycodequest.dto.progress.SkillNodeDto;
import com.mycodequest.dto.progress.SkillTreeDto;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.SkillTreeProgress;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.repository.SkillTreeProgressRepository;

@Service
public class SkillTreeService {

    private final SkillTreeProgressRepository skillTreeRepo;
    private final ProblemRepository problemRepo;

    public SkillTreeService(SkillTreeProgressRepository skillTreeRepo,
                            ProblemRepository problemRepo) {
        this.skillTreeRepo = skillTreeRepo;
        this.problemRepo = problemRepo;
    }

    /**
     * Initialize skill tree progress for a new user.
     * Unlocks the first problem in realm 1.
     */
    @Transactional
    public void initSkillTree(Long userId) {
        List<Problem> allProblems = problemRepo.findAllByOrderByRealmIdAscOrderInRealmAsc();
        for (Problem p : allProblems) {
            SkillTreeProgress stp = new SkillTreeProgress();
            stp.setUserId(userId);
            stp.setProblemId(p.getId());
            stp.setIsCompleted(false);
            // Unlock first node of realm 1 only
            stp.setIsUnlocked(p.getRealmId() == 1 && p.getOrderInRealm() == 1);
            skillTreeRepo.save(stp);
        }
    }

    /**
     * Called when a user completes a problem.
     * Marks it completed, unlocks the next node in the same realm,
     * and if boss is completed, unlocks the first node of the next realm.
     */
    @Transactional
    public void onProblemCompleted(Long userId, Long problemId) {
        // Mark completed if not already
        Optional<SkillTreeProgress> opt = skillTreeRepo.findByUserIdAndProblemId(userId, problemId);
        if (opt.isEmpty()) {
            // Create progress entry if missing
            SkillTreeProgress stp = new SkillTreeProgress();
            stp.setUserId(userId);
            stp.setProblemId(problemId);
            stp.setIsUnlocked(true);
            stp.setIsCompleted(true);
            stp.setCompletedAt(java.time.LocalDateTime.now());
            skillTreeRepo.save(stp);
        } else {
            SkillTreeProgress stp = opt.get();
            if (stp.getIsCompleted()) {
                // Already completed — nothing to do
                return;
            }
            stp.setIsCompleted(true);
            stp.setCompletedAt(java.time.LocalDateTime.now());
            skillTreeRepo.save(stp);
        }

        Problem completedProblem = problemRepo.findById(problemId).orElse(null);
        if (completedProblem == null) return;

        // Unlock the next problem in the same realm (orderInRealm + 1)
        if (completedProblem.getIsBoss() == null || !completedProblem.getIsBoss()) {
            // Find the next problem in the same realm
            List<Problem> realmProblems = problemRepo.findByRealmIdOrderByOrderInRealm(completedProblem.getRealmId());
            int nextOrder = completedProblem.getOrderInRealm() + 1;
            for (Problem p : realmProblems) {
                if (p.getOrderInRealm() == nextOrder) {
                    unlockNode(userId, p.getId());
                    break;
                }
            }

            // Check if all non-boss nodes in this realm are completed; if so, unlock the boss
            unlockBossIfRealmCleared(userId, completedProblem.getRealmId());
        } else {
            // Boss completed — unlock first node of next realm
            int nextRealmId = completedProblem.getRealmId() + 1;
            List<Problem> nextRealmProblems = problemRepo.findByRealmIdOrderByOrderInRealm(nextRealmId);
            if (!nextRealmProblems.isEmpty()) {
                // Unlock the first non-boss problem in the next realm
                for (Problem p : nextRealmProblems) {
                    if (p.getIsBoss() == null || !p.getIsBoss()) {
                        unlockNode(userId, p.getId());
                        break;
                    }
                }
            }
        }
    }

    @Transactional
    private void unlockNode(Long userId, Long problemId) {
        Optional<SkillTreeProgress> opt = skillTreeRepo.findByUserIdAndProblemId(userId, problemId);
        if (opt.isPresent()) {
            SkillTreeProgress stp = opt.get();
            stp.setIsUnlocked(true);
            skillTreeRepo.save(stp);
        } else {
            SkillTreeProgress stp = new SkillTreeProgress();
            stp.setUserId(userId);
            stp.setProblemId(problemId);
            stp.setIsUnlocked(true);
            stp.setIsCompleted(false);
            skillTreeRepo.save(stp);
        }
    }

    /**
     * Check if all non-boss problems in a realm are completed; if so, unlock the boss.
     */
    @Transactional
    public void unlockBossIfRealmCleared(Long userId, int realmId) {
        List<Problem> realmProblems = problemRepo.findByRealmIdOrderByOrderInRealm(realmId);
        List<Problem> nonBossProblems = realmProblems.stream()
                .filter(p -> p.getIsBoss() == null || !p.getIsBoss())
                .toList();

        if (nonBossProblems.isEmpty()) return;

        // Check if all non-boss are completed
        boolean allCompleted = true;
        for (Problem p : nonBossProblems) {
            Optional<SkillTreeProgress> stp = skillTreeRepo.findByUserIdAndProblemId(userId, p.getId());
            if (stp.isEmpty() || !stp.get().getIsCompleted()) {
                allCompleted = false;
                break;
            }
        }

        if (allCompleted) {
            // Find and unlock the boss problem for this realm
            for (Problem p : realmProblems) {
                if (p.getIsBoss() != null && p.getIsBoss()) {
                    unlockNode(userId, p.getId());
                    break;
                }
            }
        }
    }

    /**
     * Get the full skill tree for a user, grouped by realm.
     */
    public SkillTreeDto getSkillTree(Long userId) {
        List<Problem> allProblems = problemRepo.findAllByOrderByRealmIdAscOrderInRealmAsc();
        List<SkillTreeProgress> progressList = skillTreeRepo.findByUserId(userId);
        Map<Long, SkillTreeProgress> progressMap = new HashMap<>();
        for (SkillTreeProgress stp : progressList) {
            progressMap.put(stp.getProblemId(), stp);
        }

        // Group problems by realm
        Map<Integer, List<Problem>> byRealm = new HashMap<>();
        for (Problem p : allProblems) {
            byRealm.computeIfAbsent(p.getRealmId(), k -> new ArrayList<>()).add(p);
        }

        String[] realmNames = {
            "", // index 0 unused
            "Forest of Fundamentals",
            "Caves of Arrays",
            "String Mountains",
            "Sorting Citadel",
            "Hash Marshlands",
            "Linked List Labyrinth",
            "Tree Sanctuary"
        };

        List<SkillTreeDto.RealmDto> realmDtos = new ArrayList<>();
        for (int realmId = 1; realmId <= 7; realmId++) {
            List<Problem> realmProblems = byRealm.getOrDefault(realmId, List.of());
            List<SkillNodeDto> nodes = new ArrayList<>();
            boolean bossUnlocked = false;
            boolean bossCompleted = false;

            for (Problem p : realmProblems) {
                SkillTreeProgress stp = progressMap.get(p.getId());
                boolean unlocked = stp != null && stp.getIsUnlocked();
                boolean completed = stp != null && stp.getIsCompleted();
                boolean isBoss = p.getIsBoss() != null && p.getIsBoss();

                nodes.add(new SkillNodeDto(
                        p.getId(),
                        p.getRealmId(),
                        p.getSlug(),
                        p.getTitle(),
                        p.getDifficulty(),
                        p.getXpReward(),
                        p.getOrderInRealm(),
                        isBoss,
                        unlocked,
                        completed
                ));

                if (isBoss) {
                    bossUnlocked = unlocked;
                    bossCompleted = completed;
                }
            }

            String name = realmId < realmNames.length ? realmNames[realmId] : "Realm " + realmId;
            realmDtos.add(new SkillTreeDto.RealmDto(realmId, name, nodes, bossUnlocked, bossCompleted));
        }

        return new SkillTreeDto(realmDtos);
    }

    /**
     * Check if a specific problem is unlocked for a user.
     */
    public boolean isUnlocked(Long userId, Long problemId) {
        return skillTreeRepo.findByUserIdAndProblemId(userId, problemId)
                .map(SkillTreeProgress::getIsUnlocked)
                .orElse(false);
    }

    /**
     * Check if a specific problem is completed for a user.
     */
    public boolean isCompleted(Long userId, Long problemId) {
        return skillTreeRepo.findByUserIdAndProblemId(userId, problemId)
                .map(SkillTreeProgress::getIsCompleted)
                .orElse(false);
    }
}