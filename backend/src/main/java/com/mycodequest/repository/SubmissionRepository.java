package com.mycodequest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.Submission;

public interface SubmissionRepository extends JpaRepository<Submission, Long> {
    Page<Submission> findByUserIdAndProblemIdOrderByCreatedAtDesc(Long userId, Long problemId, Pageable pageable);
    List<Submission> findByUserIdAndProblemIdOrderByCreatedAtDesc(Long userId, Long problemId);
    long countByUserIdAndStatus(Long userId, String status);
    Optional<Submission> findFirstByUserIdAndProblemIdAndStatusNotOrderByCreatedAtDesc(Long userId, Long problemId, String status);
}