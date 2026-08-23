package com.mycodequest.dto.problem;

public record PatternHintDto(
    String patternName,
    String relatedProblemSlug,
    String relatedProblemTitle
) {}