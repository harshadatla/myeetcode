package com.mycodequest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.mycodequest.dto.auth.AuthResponse;
import com.mycodequest.dto.auth.LoginRequest;
import com.mycodequest.dto.auth.RegisterRequest;
import com.mycodequest.entity.User;
import com.mycodequest.service.AuthService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody RegisterRequest req) {
        return ResponseEntity.ok(authService.register(req));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest req) {
        return ResponseEntity.ok(authService.login(req));
    }

    @GetMapping("/me")
    public ResponseEntity<AuthResponse> me(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        User user = authService.getUserById(userId);
        return ResponseEntity.ok(new AuthResponse(
                null, user.getId(), user.getUsername(), user.getEmail(),
                user.getLevel(), user.getXp(), user.getHp(), user.getStreak()
        ));
    }
}