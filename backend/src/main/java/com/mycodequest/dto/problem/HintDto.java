package com.mycodequest.dto.problem;

public record HintDto(
    int layer,
    String name,
    String icon,
    String content,
    int hpCost,
    boolean unlocked,
    String hintType
) {}