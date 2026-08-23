package com.mycodequest.dto.auth;

public record AuthResponse(String token, Long userId, String username, String email, Integer level, Integer xp, Integer hp, Integer streak) {}