package com.mycodequest.dto.problem;

public record ProblemDto(
    Long id,
    int realmId,
    String slug,
    String title,
    String difficulty,
    int xpReward,
    int orderInRealm,
    boolean isBoss,
    boolean completed,
    boolean unlocked
) {}