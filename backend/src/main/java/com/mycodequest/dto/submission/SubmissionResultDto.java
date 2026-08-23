package com.mycodequest.dto.submission;

import java.util.List;

public record SubmissionResultDto(
    String status,
    int passedCount,
    int totalCount,
    List<TestCaseResultDto> results,
    int xpGained,
    int newTotalXp,
    int newLevel,
    boolean leveledUp,
    int hpRemaining,
    List<String> newAchievements,
    boolean bossDefeated
) {
    public record TestCaseResultDto(
        int caseNum,
        String status,
        String input,
        String expectedOutput,
        String actualOutput,
        int timeMs,
        int memoryKb
    ) {}
}