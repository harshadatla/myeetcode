package com.mycodequest.dto.progress;

import java.util.List;

public record SkillTreeDto(
    List<RealmDto> realms
) {
    public record RealmDto(
        int realmId,
        String name,
        List<SkillNodeDto> nodes,
        boolean bossUnlocked,
        boolean bossCompleted
    ) {}
}