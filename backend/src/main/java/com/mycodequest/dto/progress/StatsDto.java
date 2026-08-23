package com.mycodequest.dto.progress;

public record StatsDto(
    int level,
    int xp,
    int hp,
    int maxHp,
    int streak,
    String rank,
    int totalSolved,
    int easySolved,
    int mediumSolved,
    int hardSolved,
    int bossSolved
) {}