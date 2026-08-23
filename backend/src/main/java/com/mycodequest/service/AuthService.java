package com.mycodequest.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycodequest.dto.auth.AuthResponse;
import com.mycodequest.dto.auth.LoginRequest;
import com.mycodequest.dto.auth.RegisterRequest;
import com.mycodequest.entity.User;
import com.mycodequest.repository.UserRepository;
import com.mycodequest.security.JwtTokenProvider;

@Service
public class AuthService {

    private final UserRepository userRepo;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider tokenProvider;

    public AuthService(UserRepository userRepo, PasswordEncoder passwordEncoder, JwtTokenProvider tokenProvider) {
        this.userRepo = userRepo;
        this.passwordEncoder = passwordEncoder;
        this.tokenProvider = tokenProvider;
    }

    @Transactional
    public AuthResponse register(RegisterRequest req) {
        if (userRepo.existsByEmail(req.email())) {
            throw new IllegalArgumentException("Email already registered");
        }
        if (userRepo.existsByUsername(req.username())) {
            throw new IllegalArgumentException("Username already taken");
        }

        User user = new User(req.email(), req.username(), passwordEncoder.encode(req.password()));
        userRepo.save(user);

        String token = tokenProvider.generate(user.getId(), user.getUsername());
        return toAuthResponse(user, token);
    }

    public AuthResponse login(LoginRequest req) {
        User user = userRepo.findByEmail(req.email())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password"));

        if (!passwordEncoder.matches(req.password(), user.getPasswordHash())) {
            throw new IllegalArgumentException("Invalid email or password");
        }

        String token = tokenProvider.generate(user.getId(), user.getUsername());
        return toAuthResponse(user, token);
    }

    public User getUserById(Long userId) {
        return userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
    }

    private AuthResponse toAuthResponse(User user, String token) {
        return new AuthResponse(
                token,
                user.getId(),
                user.getUsername(),
                user.getEmail(),
                user.getLevel(),
                user.getXp(),
                user.getHp(),
                user.getStreak()
        );
    }
}