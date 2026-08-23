package com.mycodequest.dto.progress;

import java.time.LocalDateTime;

public record AchievementDto(
    String key,
    String name,
    String description,
    String icon,
    boolean unlocked,
    LocalDateTime unlockedAt
) {}