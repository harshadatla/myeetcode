package com.mycodequest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.UserAchievement;

public interface UserAchievementRepository extends JpaRepository<UserAchievement, Long> {
    List<UserAchievement> findByUserId(Long userId);
    boolean existsByUserIdAndAchievementKey(Long userId, String achievementKey);
}