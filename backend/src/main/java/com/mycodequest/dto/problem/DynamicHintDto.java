package com.mycodequest.dto.problem;

public record DynamicHintDto(
    String hintType,
    String content,
    Integer lineNumber,
    String exceptionType,
    int hpCost
) {}