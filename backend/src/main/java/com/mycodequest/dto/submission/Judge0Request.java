package com.mycodequest.dto.submission;

public record Judge0Request(
    String sourceCode,
    int languageId,
    String stdin,
    String expectedOutput,
    double cpuTimeLimit,
    int memoryLimit
) {}