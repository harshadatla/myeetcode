package com.mycodequest.dto.submission;

import java.time.LocalDateTime;

public record SubmissionDto(
    Long id,
    Long problemId,
    String status,
    String sourceCode,
    Integer executionTimeMs,
    Integer memoryUsedKb,
    LocalDateTime createdAt
) {}