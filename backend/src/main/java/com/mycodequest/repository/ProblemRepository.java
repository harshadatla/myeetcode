package com.mycodequest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycodequest.entity.Problem;

public interface ProblemRepository extends JpaRepository<Problem, Long> {
    Optional<Problem> findBySlug(String slug);
    List<Problem> findByRealmIdOrderByOrderInRealm(int realmId);
    List<Problem> findAllByOrderByRealmIdAscOrderInRealmAsc();
}