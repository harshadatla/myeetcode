package com.mycodequest.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.mycodequest.dto.submission.SubmissionDto;
import com.mycodequest.dto.submission.SubmissionResultDto;
import com.mycodequest.dto.submission.SubmitRequest;
import com.mycodequest.service.SubmissionService;

@RestController
@RequestMapping("/api/submissions")
public class SubmissionController {

    private final SubmissionService submissionService;

    public SubmissionController(SubmissionService submissionService) {
        this.submissionService = submissionService;
    }

    @PostMapping
    public ResponseEntity<SubmissionResultDto> submit(@RequestBody SubmitRequest req, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(submissionService.submit(userId, req));
    }

    @GetMapping("/{id}")
    public ResponseEntity<SubmissionDto> getSubmission(@PathVariable Long id, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(submissionService.getSubmission(id, userId));
    }

    @GetMapping
    public ResponseEntity<List<SubmissionDto>> getHistory(
            @RequestParam Long problemId,
            Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(submissionService.getHistory(userId, problemId));
    }
}