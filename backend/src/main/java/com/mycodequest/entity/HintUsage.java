package com.mycodequest.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
@Table(name = "hint_usage")
public class HintUsage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "problem_id")
    private Long problemId;

    @Column(name = "hint_layer")
    private Integer hintLayer;

    @Column(name = "hint_type")
    private String hintType;

    @Column(name = "hp_cost")
    private Integer hpCost;

    @Column(columnDefinition = "TEXT")
    private String content;

    @Column(name = "unlocked_at")
    private LocalDateTime unlockedAt = LocalDateTime.now();

    public HintUsage() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Long getProblemId() { return problemId; }
    public void setProblemId(Long problemId) { this.problemId = problemId; }
    public Integer getHintLayer() { return hintLayer; }
    public void setHintLayer(Integer hintLayer) { this.hintLayer = hintLayer; }
    public String getHintType() { return hintType; }
    public void setHintType(String hintType) { this.hintType = hintType; }
    public Integer getHpCost() { return hpCost; }
    public void setHpCost(Integer hpCost) { this.hpCost = hpCost; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public LocalDateTime getUnlockedAt() { return unlockedAt; }
    public void setUnlockedAt(LocalDateTime unlockedAt) { this.unlockedAt = unlockedAt; }
}