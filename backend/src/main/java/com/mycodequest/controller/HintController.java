package com.mycodequest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.mycodequest.dto.problem.DynamicHintDto;
import com.mycodequest.dto.problem.HintDto;
import com.mycodequest.dto.problem.HintStateDto;
import com.mycodequest.entity.Problem;
import com.mycodequest.exception.NotFoundException;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.service.HintService;

@RestController
@RequestMapping("/api/problems/{slug}/hints")
public class HintController {

    private final HintService hintService;
    private final ProblemRepository problemRepo;

    public HintController(HintService hintService, ProblemRepository problemRepo) {
        this.hintService = hintService;
        this.problemRepo = problemRepo;
    }

    @GetMapping
    public ResponseEntity<HintStateDto> getHints(@PathVariable String slug, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        Problem problem = problemRepo.findBySlug(slug)
            .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
        return ResponseEntity.ok(hintService.getHintState(userId, problem.getId()));
    }

    @GetMapping("/state")
    public ResponseEntity<HintStateDto> getHintState(@PathVariable String slug, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        Problem problem = problemRepo.findBySlug(slug)
            .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
        return ResponseEntity.ok(hintService.getHintState(userId, problem.getId()));
    }

    @PostMapping("/unlock")
    public ResponseEntity<HintDto> unlockHint(@PathVariable String slug,
                                              @RequestBody UnlockHintRequest req,
                                              Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        Problem problem = problemRepo.findBySlug(slug)
            .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
        return ResponseEntity.ok(hintService.unlockStaticHint(userId, problem.getId(), req.layer()));
    }

    @PostMapping("/dynamic")
    public ResponseEntity<DynamicHintDto> getDynamicHint(@PathVariable String slug, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        Problem problem = problemRepo.findBySlug(slug)
            .orElseThrow(() -> new NotFoundException("Problem not found: " + slug));
        return ResponseEntity.ok(hintService.getDynamicHint(userId, problem.getId()));
    }

    public record UnlockHintRequest(int layer) {}
}