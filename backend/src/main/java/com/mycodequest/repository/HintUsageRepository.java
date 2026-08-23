package com.mycodequest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.HintUsage;

public interface HintUsageRepository extends JpaRepository<HintUsage, Long> {
    List<HintUsage> findByUserIdAndProblemId(Long userId, Long problemId);
    boolean existsByUserIdAndProblemIdAndHintType(Long userId, Long problemId, String hintType);
    int countByUserIdAndProblemId(Long userId, Long problemId);
}