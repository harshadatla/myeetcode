package com.mycodequest.dto.progress;

public record SkillNodeDto(
    Long problemId,
    int realmId,
    String slug,
    String title,
    String difficulty,
    int xpReward,
    int orderInRealm,
    boolean isBoss,
    boolean unlocked,
    boolean completed
) {}