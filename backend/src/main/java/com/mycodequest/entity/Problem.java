package com.mycodequest.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
@Table(name = "problems")
public class Problem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "realm_id")
    private Integer realmId;

    @Column(unique = true, nullable = false)
    private String slug;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private String difficulty;

    @Column(name = "xp_reward")
    private Integer xpReward;

    @Column(name = "order_in_realm")
    private Integer orderInRealm;

    @Column(name = "starter_code", nullable = false, columnDefinition = "TEXT")
    private String starterCode;

    @Column(name = "solution_code", columnDefinition = "TEXT")
    private String solutionCode;

    @Column(name = "time_limit_ms")
    private Integer timeLimitMs = 2000;

    @Column(name = "memory_limit_kb")
    private Integer memoryLimitKb = 256000;

    @Column(name = "is_boss")
    private Boolean isBoss = false;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    public Problem() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Integer getRealmId() { return realmId; }
    public void setRealmId(Integer realmId) { this.realmId = realmId; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    public Integer getXpReward() { return xpReward; }
    public void setXpReward(Integer xpReward) { this.xpReward = xpReward; }
    public Integer getOrderInRealm() { return orderInRealm; }
    public void setOrderInRealm(Integer orderInRealm) { this.orderInRealm = orderInRealm; }
    public String getStarterCode() { return starterCode; }
    public void setStarterCode(String starterCode) { this.starterCode = starterCode; }
    public String getSolutionCode() { return solutionCode; }
    public void setSolutionCode(String solutionCode) { this.solutionCode = solutionCode; }
    public Integer getTimeLimitMs() { return timeLimitMs; }
    public void setTimeLimitMs(Integer timeLimitMs) { this.timeLimitMs = timeLimitMs; }
    public Integer getMemoryLimitKb() { return memoryLimitKb; }
    public void setMemoryLimitKb(Integer memoryLimitKb) { this.memoryLimitKb = memoryLimitKb; }
    public Boolean getIsBoss() { return isBoss; }
    public void setIsBoss(Boolean isBoss) { this.isBoss = isBoss; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}