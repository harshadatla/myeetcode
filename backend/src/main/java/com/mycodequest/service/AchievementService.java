package com.mycodequest.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycodequest.dto.progress.AchievementDto;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.Submission;
import com.mycodequest.entity.User;
import com.mycodequest.entity.UserAchievement;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.repository.SubmissionRepository;
import com.mycodequest.repository.UserAchievementRepository;

@Service
public class AchievementService {

    private final UserAchievementRepository achievementRepo;
    private final SubmissionRepository submissionRepo;
    private final ProblemRepository problemRepo;

    // Achievement metadata
    private static final Map<String, String[]> ACHIEVEMENT_META = new HashMap<>();
    static {
        ACHIEVEMENT_META.put("FIRST_BLOOD", new String[]{"First Blood", "Solve your first problem", "🩸"});
        ACHIEVEMENT_META.put("COMBO_MASTER", new String[]{"Combo Master", "5 correct submissions in a row", "🔥"});
        ACHIEVEMENT_META.put("SPEED_DEMON", new String[]{"Speed Demon", "Solve a medium in under 5 minutes", "⚡"});
        ACHIEVEMENT_META.put("UNTOUCHABLE", new String[]{"Untouchable", "Solve a hard with 0 wrong submissions", "🛡️"});
        ACHIEVEMENT_META.put("REALM_CONQUEROR", new String[]{"Realm Conqueror", "Clear all nodes in a realm", "👑"});
        ACHIEVEMENT_META.put("STREAK_30", new String[]{"30-Day Warrior", "30-day solve streak", "📅"});
        ACHIEVEMENT_META.put("SAGE", new String[]{"Java Sage", "Reach level 50", "🧙"});
        ACHIEVEMENT_META.put("NO_HINT_NO_PROBLEM", new String[]{"No Hint, No Problem", "Solve medium/hard without hints", "💡"});
    }

    public AchievementService(UserAchievementRepository achievementRepo,
                               SubmissionRepository submissionRepo,
                               ProblemRepository problemRepo) {
        this.achievementRepo = achievementRepo;
        this.submissionRepo = submissionRepo;
        this.problemRepo = problemRepo;
    }

    /**
     * Check and award all relevant achievements after a successful submission.
     * Returns the list of newly unlocked achievement keys.
     */
    @Transactional
    public List<String> checkAchievements(Long userId, User user, Problem problem, Submission submission) {
        List<String> newAchievements = new ArrayList<>();

        // FIRST_BLOOD: first ever accepted submission
        if (!hasAchievement(userId, "FIRST_BLOOD")) {
            long acceptedCount = submissionRepo.countByUserIdAndStatus(userId, "ACCEPTED");
            if (acceptedCount >= 1) {
                unlockAchievement(userId, "FIRST_BLOOD");
                newAchievements.add("FIRST_BLOOD");
            }
        }

        // COMBO_MASTER: 5 consecutive accepted submissions (no failures in between)
        if (!hasAchievement(userId, "COMBO_MASTER")) {
            if (checkConsecutiveAccepted(userId, problem.getId(), 5)) {
                unlockAchievement(userId, "COMBO_MASTER");
                newAchievements.add("COMBO_MASTER");
            }
        }

        // SPEED_DEMON: solve a medium problem within 5 minutes of first submission for that problem
        if (!hasAchievement(userId, "SPEED_DEMON") && "MEDIUM".equals(problem.getDifficulty())) {
            if (checkSpeedDemon(userId, problem.getId())) {
                unlockAchievement(userId, "SPEED_DEMON");
                newAchievements.add("SPEED_DEMON");
            }
        }

        // UNTOUCHABLE: solve a hard problem with 0 prior wrong submissions
        if (!hasAchievement(userId, "UNTOUCHABLE") && "HARD".equals(problem.getDifficulty())) {
            if (checkUntouchable(userId, problem.getId())) {
                unlockAchievement(userId, "UNTOUCHABLE");
                newAchievements.add("UNTOUCHABLE");
            }
        }

        // STREAK_30: 30-day streak reached
        if (!hasAchievement(userId, "STREAK_30") && user.getStreak() >= 30) {
            unlockAchievement(userId, "STREAK_30");
            newAchievements.add("STREAK_30");
        }

        // SAGE: reach level 50
        if (!hasAchievement(userId, "SAGE") && user.getLevel() >= 50) {
            unlockAchievement(userId, "SAGE");
            newAchievements.add("SAGE");
        }

        return newAchievements;
    }

    /**
     * Check REALM_CONQUEROR: all non-boss + boss in a realm completed.
     */
    @Transactional
    public List<String> checkRealmConqueror(Long userId, int realmId) {
        List<String> newAchievements = new ArrayList<>();
        if (hasAchievement(userId, "REALM_CONQUEROR")) {
            return newAchievements;
        }

        List<Problem> realmProblems = problemRepo.findByRealmIdOrderByOrderInRealm(realmId);
        // Check if all problems in this realm have accepted submissions
        boolean allCompleted = true;
        for (Problem p : realmProblems) {
            List<Submission> subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, p.getId());
            boolean hasAccepted = subs.stream().anyMatch(s -> "ACCEPTED".equals(s.getStatus()));
            if (!hasAccepted) {
                allCompleted = false;
                break;
            }
        }

        if (allCompleted && !realmProblems.isEmpty()) {
            unlockAchievement(userId, "REALM_CONQUEROR");
            newAchievements.add("REALM_CONQUEROR");
        }
        return newAchievements;
    }

    /**
     * Get all achievements with unlock status for a user.
     */
    public List<AchievementDto> getAllAchievements(Long userId) {
        List<UserAchievement> unlocked = achievementRepo.findByUserId(userId);
        Map<String, LocalDateTime> unlockMap = new HashMap<>();
        for (UserAchievement ua : unlocked) {
            unlockMap.put(ua.getAchievementKey(), ua.getUnlockedAt());
        }

        List<AchievementDto> result = new ArrayList<>();
        for (Map.Entry<String, String[]> entry : ACHIEVEMENT_META.entrySet()) {
            String key = entry.getKey();
            String[] meta = entry.getValue();
            boolean isUnlocked = unlockMap.containsKey(key);
            LocalDateTime unlockedAt = unlockMap.get(key);
            result.add(new AchievementDto(
                    key,
                    meta[0], // name
                    meta[1], // description
                    meta[2], // icon
                    isUnlocked,
                    unlockedAt
            ));
        }
        return result;
    }

    private boolean hasAchievement(Long userId, String key) {
        return achievementRepo.existsByUserIdAndAchievementKey(userId, key);
    }

    @Transactional
    private void unlockAchievement(Long userId, String key) {
        if (!hasAchievement(userId, key)) {
            UserAchievement ua = new UserAchievement();
            ua.setUserId(userId);
            ua.setAchievementKey(key);
            achievementRepo.save(ua);
        }
    }

    /**
     * Check if the last N submissions for a problem are all accepted (consecutive combo).
     */
    private boolean checkConsecutiveAccepted(Long userId, Long problemId, int required) {
        List<Submission> subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problemId);
        // Count consecutive accepted from the most recent
        int consecutive = 0;
        for (Submission s : subs) {
            if ("ACCEPTED".equals(s.getStatus())) {
                consecutive++;
                if (consecutive >= required) return true;
            } else {
                break;
            }
        }
        return false;
    }

    /**
     * Check if the user solved a medium problem within 5 minutes of their first submission for it.
     */
    private boolean checkSpeedDemon(Long userId, Long problemId) {
        List<Submission> subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problemId);
        if (subs.isEmpty()) return false;

        // First submission (oldest) and accepted submission (most recent accepted)
        Submission first = subs.get(subs.size() - 1); // oldest
        Submission latestAccepted = subs.stream()
                .filter(s -> "ACCEPTED".equals(s.getStatus()))
                .findFirst()
                .orElse(null);

        if (latestAccepted == null || first == null) return false;

        // Check if accepted within 5 minutes of first submission
        return java.time.Duration.between(first.getCreatedAt(), latestAccepted.getCreatedAt()).toMinutes() < 5;
    }

    /**
     * Check if the user solved a hard problem with 0 prior wrong submissions.
     */
    private boolean checkUntouchable(Long userId, Long problemId) {
        List<Submission> subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problemId);
        // Must have at least one accepted, and none that are not accepted
        boolean hasAccepted = subs.stream().anyMatch(s -> "ACCEPTED".equals(s.getStatus()));
        boolean hasWrong = subs.stream().anyMatch(s -> !"ACCEPTED".equals(s.getStatus()));
        return hasAccepted && !hasWrong;
    }
}