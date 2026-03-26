package com.codeforce.controller;

import com.codeforce.model.Problem;
import com.codeforce.model.Submission;
import com.codeforce.model.User;
import com.codeforce.service.ProblemService;
import com.codeforce.service.SubmissionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@Controller
public class ProblemController {

    private final ProblemService problemService;
    private final SubmissionService submissionService;

    @Autowired
    public ProblemController(ProblemService problemService, SubmissionService submissionService) {
        this.problemService = problemService;
        this.submissionService = submissionService;
    }

    @GetMapping("/problemset")
    public String problemset(@RequestParam(required = false) String tag,
                             @RequestParam(required = false) Integer minDiff,
                             @RequestParam(required = false) Integer maxDiff,
                             Model model, HttpSession session) {
        List<Problem> problems;

        if (tag != null && !tag.isEmpty()) {
            problems = problemService.findByTag(tag);
        } else if (minDiff != null && maxDiff != null) {
            problems = problemService.findByDifficultyRange(minDiff, maxDiff);
        } else {
            problems = problemService.getAllProblems();
        }

        model.addAttribute("problems", problems);
        model.addAttribute("selectedTag", tag);
        model.addAttribute("minDiff", minDiff);
        model.addAttribute("maxDiff", maxDiff);
        model.addAttribute("currentUser", session.getAttribute("currentUser"));

        return "problemset";
    }

    @GetMapping("/problem/{id}")
    public String problemDetail(@PathVariable Long id, 
                                @RequestParam(required = false) Long contestId,
                                @RequestParam(required = false) Boolean retry,
                                Model model, HttpSession session) {
        return problemService.findById(id)
                .map(problem -> {
                    model.addAttribute("problem", problem);
                    model.addAttribute("currentUser", session.getAttribute("currentUser"));
                    model.addAttribute("contestId", contestId);
                    model.addAttribute("isSecondChance", retry != null && retry);
                    return "problem-detail";
                })
                .orElse("redirect:/problemset");
    }

    @PostMapping("/problem/{id}/submit")
    public String submitSolution(@PathVariable Long id,
                                  @RequestParam String language,
                                  @RequestParam String sourceCode,
                                  @RequestParam(required = false) Long contestId,
                                  @RequestParam(required = false) Boolean isSecondChance,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        return problemService.findById(id)
                .map(problem -> {
                    // Simulate verdict
                    String[] verdicts = {"Accepted", "Wrong Answer", "Time Limit Exceeded", "Runtime Error"};
                    Random random = new Random();
                    String verdict = verdicts[random.nextInt(verdicts.length)];

                    Submission submission = new Submission();
                    submission.setUser(currentUser);
                    submission.setProblem(problem);
                    submission.setProgrammingLanguage(language);
                    submission.setVerdict(verdict);
                    submission.setTimeConsumedMs(random.nextInt(1500) + 50);
                    submission.setMemoryConsumedKb(random.nextInt(200000) + 10000);
                    submission.setSourceCode(sourceCode);
                    submission.setSubmittedAt(LocalDateTime.now());
                    submission.setPassedTestCount(verdict.equals("Accepted") ? "All" : String.valueOf(random.nextInt(20) + 1));
                    
                    if (isSecondChance != null && isSecondChance && contestId != null) {
                        submission.setSecondChance(true);
                        com.codeforce.model.Contest contest = new com.codeforce.model.Contest();
                        contest.setId(contestId);
                        submission.setContest(contest);
                    }

                    submissionService.submit(submission);

                    if (verdict.equals("Accepted")) {
                        problem.setSolvedCount(problem.getSolvedCount() + 1);
                        problemService.save(problem);
                    }

                    redirectAttributes.addFlashAttribute("verdict", verdict);
                    redirectAttributes.addFlashAttribute("submission", submission);
                    return "redirect:/problem/" + id;
                })
                .orElse("redirect:/problemset");
    }
}
