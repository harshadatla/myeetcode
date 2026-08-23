package com.mycodequest.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.mycodequest.dto.problem.ProblemDetailDto;
import com.mycodequest.dto.problem.ProblemDto;
import com.mycodequest.dto.problem.TestCaseDto;
import com.mycodequest.service.ProblemService;

@RestController
@RequestMapping("/api/problems")
public class ProblemController {

    private final ProblemService problemService;

    public ProblemController(ProblemService problemService) {
        this.problemService = problemService;
    }

    @GetMapping
    public ResponseEntity<List<ProblemDto>> getAllProblems(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(problemService.getAllProblems(userId));
    }

    @GetMapping("/{slug}")
    public ResponseEntity<ProblemDetailDto> getProblem(@PathVariable String slug, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(problemService.getProblem(slug, userId));
    }

    @GetMapping("/{slug}/test-cases")
    public ResponseEntity<List<TestCaseDto>> getTestCases(@PathVariable String slug, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(problemService.getTestCases(slug, userId));
    }
}