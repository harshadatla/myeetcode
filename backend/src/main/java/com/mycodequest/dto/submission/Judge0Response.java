package com.mycodequest.dto.submission;

public record Judge0Response(
    String token,
    Judge0Status status,
    String stdout,
    String stderr,
    String compileOutput,
    String time,
    Integer memory
) {
    public record Judge0Status(int id, String description) {}
}