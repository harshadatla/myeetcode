package com.mycodequest.dto.submission;

public record SubmitRequest(
    String slug,
    String sourceCode,
    boolean runSampleOnly
) {}