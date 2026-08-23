package com.mycodequest.dto.problem;

import java.util.List;

public record HintStateDto(
    List<HintDto> staticHints,
    boolean dynamicAvailable,
    String lastFailureType,
    int totalHpSpentOnHints,
    int hintsUnlockedCount,
    List<PatternHintDto> patternHints
) {}