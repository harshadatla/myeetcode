package com.mycodequest.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.mycodequest.dto.progress.AchievementDto;
import com.mycodequest.dto.progress.SkillTreeDto;
import com.mycodequest.dto.progress.StatsDto;
import com.mycodequest.entity.User;
import com.mycodequest.repository.ProblemRepository;
import com.mycodequest.repository.SubmissionRepository;
import com.mycodequest.repository.UserRepository;
import com.mycodequest.service.AchievementService;
import com.mycodequest.service.ProgressService;
import com.mycodequest.service.SkillTreeService;

@RestController
@RequestMapping("/api/progress")
public class ProgressController {

    private final SkillTreeService skillTreeService;
    private final ProgressService progressService;
    private final AchievementService achievementService;
    private final UserRepository userRepo;
    private final SubmissionRepository submissionRepo;
    private final ProblemRepository problemRepo;

    public ProgressController(SkillTreeService skillTreeService,
                              ProgressService progressService,
                              AchievementService achievementService,
                              UserRepository userRepo,
                              SubmissionRepository submissionRepo,
                              ProblemRepository problemRepo) {
        this.skillTreeService = skillTreeService;
        this.progressService = progressService;
        this.achievementService = achievementService;
        this.userRepo = userRepo;
        this.submissionRepo = submissionRepo;
        this.problemRepo = problemRepo;
    }

    @GetMapping("/skill-tree")
    public ResponseEntity<SkillTreeDto> getSkillTree(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(skillTreeService.getSkillTree(userId));
    }

    @GetMapping("/stats")
    public ResponseEntity<StatsDto> getStats(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Count solved by difficulty
        long totalSolved = submissionRepo.countByUserIdAndStatus(userId, "ACCEPTED");
        // For difficulty breakdown, we need to check which problems have accepted submissions
        // and their difficulty levels
        int easySolved = 0;
        int mediumSolved = 0;
        int hardSolved = 0;
        int bossSolved = 0;

        // Get all problems and check which the user has solved
        var allProblems = problemRepo.findAll();
        for (var problem : allProblems) {
            var subs = submissionRepo.findByUserIdAndProblemIdOrderByCreatedAtDesc(userId, problem.getId());
            boolean solved = subs.stream().anyMatch(s -> "ACCEPTED".equals(s.getStatus()));
            if (solved) {
                String diff = problem.getDifficulty();
                if ("EASY".equals(diff)) easySolved++;
                else if ("MEDIUM".equals(diff)) mediumSolved++;
                else if ("HARD".equals(diff)) hardSolved++;
                else if ("BOSS".equals(diff)) bossSolved++;
            }
        }

        String rank = progressService.getRank(user.getLevel());

        return ResponseEntity.ok(new StatsDto(
                user.getLevel(),
                user.getXp(),
                user.getHp(),
                100,
                user.getStreak(),
                rank,
                (int) totalSolved,
                easySolved,
                mediumSolved,
                hardSolved,
                bossSolved
        ));
    }

    @GetMapping("/achievements")
    public ResponseEntity<List<AchievementDto>> getAchievements(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return ResponseEntity.ok(achievementService.getAllAchievements(userId));
    }
}