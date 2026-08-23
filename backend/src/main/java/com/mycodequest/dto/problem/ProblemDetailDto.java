package com.mycodequest.dto.problem;

import java.util.List;

public record ProblemDetailDto(
    Long id,
    int realmId,
    String slug,
    String title,
    String description,
    String difficulty,
    int xpReward,
    String starterCode,
    List<TestCaseDto> sampleTests,
    List<HintDto> hints,
    boolean isBoss,
    int timeLimitMs,
    int memoryLimitKb
) {}