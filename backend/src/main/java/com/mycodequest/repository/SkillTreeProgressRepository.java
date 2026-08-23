package com.mycodequest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.SkillTreeProgress;

public interface SkillTreeProgressRepository extends JpaRepository<SkillTreeProgress, Long> {
    List<SkillTreeProgress> findByUserId(Long userId);
    Optional<SkillTreeProgress> findByUserIdAndProblemId(Long userId, Long problemId);
}