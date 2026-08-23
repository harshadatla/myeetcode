package com.mycodequest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.Hint;

public interface HintRepository extends JpaRepository<Hint, Long> {
    List<Hint> findByProblemIdOrderByLayer(Long problemId);
    Optional<Hint> findByProblemIdAndLayer(Long problemId, int layer);
}