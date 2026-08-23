package com.mycodequest.dto.problem;

public record TestCaseDto(
    String input,
    String expectedOutput,
    boolean isHidden
) {}