package com.mycodequest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.ProblemPattern;

public interface ProblemPatternRepository extends JpaRepository<ProblemPattern, Long> {
    List<ProblemPattern> findByProblemId(Long problemId);
}