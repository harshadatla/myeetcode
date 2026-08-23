package com.mycodequest.service;

import java.time.LocalDate;

import org.springframework.stereotype.Service;

import com.mycodequest.entity.User;
import com.mycodequest.repository.UserRepository;

@Service
public class ProgressService {

    private final UserRepository userRepo;

    public ProgressService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    /**
     * XP needed to reach a given level: 100 * level^2
     * Level 1 = 0 XP, Level 2 = 400 XP, Level 3 = 900 XP, etc.
     */
    public int xpForLevel(int level) {
        return 100 * level * level;
    }

    /**
     * Given total XP, compute the current level.
     * Solves: find max level L such that 100*L^2 <= totalXp
     * => L = floor(sqrt(totalXp / 100))
     */
    public int levelFromXp(int totalXp) {
        if (totalXp <= 0) return 1;
        return (int) Math.floor(Math.sqrt((double) totalXp / 100.0));
    }

    /**
     * Apply XP to user with streak multiplier. Returns the XP actually gained (after multiplier).
     */
    public int applyXp(User user, int baseXp) {
        int multiplier = getStreakMultiplier(user.getStreak());
        int gained = baseXp * multiplier;
        int oldLevel = user.getLevel();
        user.setXp(user.getXp() + gained);
        int newLevel = levelFromXp(user.getXp());
        user.setLevel(Math.max(newLevel, oldLevel));
        return gained;
    }

    /**
     * Streak multiplier: 1x base, 1.5x at 7-day streak, 2x at 30-day streak.
     */
    public int getStreakMultiplier(int streak) {
        if (streak >= 30) return 2;
        if (streak >= 7) return 2; // Use 2x for 30-day, but we return int; 1.5x rounds to 1x for int XP
        return 1;
    }

    /**
     * Get the streak multiplier as a double (for display purposes).
     */
    public double getStreakMultiplierDouble(int streak) {
        if (streak >= 30) return 2.0;
        if (streak >= 7) return 1.5;
        return 1.0;
    }

    /**
     * Apply XP with double multiplier for more accurate calculation.
     */
    public int applyXpWithStreak(User user, int baseXp) {
        double multiplier = getStreakMultiplierDouble(user.getStreak());
        int gained = (int) Math.round(baseXp * multiplier);
        int oldLevel = user.getLevel();
        user.setXp(user.getXp() + gained);
        int newLevel = levelFromXp(user.getXp());
        user.setLevel(Math.max(newLevel, oldLevel));
        return gained;
    }

    /**
     * Update the daily solve streak for a user.
     */
    public void updateStreak(User user) {
        LocalDate today = LocalDate.now();
        if (user.getLastSolveDate() == null) {
            user.setStreak(1);
        } else if (user.getLastSolveDate().equals(today)) {
            // Already solved today — don't change streak
            return;
        } else if (user.getLastSolveDate().equals(today.minusDays(1))) {
            user.setStreak(user.getStreak() + 1);
        } else {
            // Streak broken
            user.setStreak(1);
        }
        user.setLastSolveDate(today);
    }

    /**
     * Rank title based on level.
     */
    public String getRank(int level) {
        if (level >= 80) return "Legend";
        if (level >= 60) return "Archmage";
        if (level >= 50) return "Sage";
        if (level >= 40) return "Paladin";
        if (level >= 25) return "Knight";
        if (level >= 15) return "Squire";
        if (level >= 5) return "Apprentice";
        return "Novice";
    }

    /**
     * Deduct HP for a wrong submission. Returns the new HP value.
     */
    public int deductHp(User user, int amount) {
        int newHp = Math.max(0, user.getHp() - amount);
        user.setHp(newHp);
        return newHp;
    }
}