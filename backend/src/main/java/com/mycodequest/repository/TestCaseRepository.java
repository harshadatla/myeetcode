package com.mycodequest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.TestCase;

public interface TestCaseRepository extends JpaRepository<TestCase, Long> {
    List<TestCase> findByProblemIdOrderByOrderNum(Long problemId);
    List<TestCase> findByProblemIdAndIsHiddenFalseOrderByOrderNum(Long problemId);
    List<TestCase> findByProblemIdAndIsHiddenTrueOrderByOrderNum(Long problemId);
}