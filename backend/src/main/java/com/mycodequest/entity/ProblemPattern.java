package com.mycodequest.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "problem_patterns")
public class ProblemPattern {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "problem_id")
    private Long problemId;

    @Column(name = "pattern_name")
    private String patternName;

    public ProblemPattern() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getProblemId() { return problemId; }
    public void setProblemId(Long problemId) { this.problemId = problemId; }
    public String getPatternName() { return patternName; }
    public void setPatternName(String patternName) { this.patternName = patternName; }
}