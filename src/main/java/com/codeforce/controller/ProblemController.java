package com.codeforce.controller;

import com.codeforce.model.Problem;
import com.codeforce.model.Submission;
import com.codeforce.model.User;
import com.codeforce.service.ProblemService;
import com.codeforce.service.SubmissionService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@Controller
@RequiredArgsConstructor
public class ProblemController {

    private final ProblemService problemService;
    private final SubmissionService submissionService;

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
    public String problemDetail(@PathVariable Long id, Model model, HttpSession session) {
        return problemService.findById(id)
                .map(problem -> {
                    model.addAttribute("problem", problem);
                    model.addAttribute("currentUser", session.getAttribute("currentUser"));
                    return "problem-detail";
                })
                .orElse("redirect:/problemset");
    }

    @PostMapping("/problem/{id}/submit")
    public String submitSolution(@PathVariable Long id,
                                  @RequestParam String language,
                                  @RequestParam String sourceCode,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        return problemService.findById(id)
                .map(problem -> {
                    // Simulate verdict (in a real system this would compile and run code)
                    String[] verdicts = {"Accepted", "Wrong Answer", "Time Limit Exceeded", "Runtime Error"};
                    Random random = new Random();
                    String verdict = verdicts[random.nextInt(verdicts.length)];

                    Submission submission = Submission.builder()
                            .user(currentUser)
                            .problem(problem)
                            .programmingLanguage(language)
                            .verdict(verdict)
                            .timeConsumedMs(random.nextInt(1500) + 50)
                            .memoryConsumedKb(random.nextInt(200000) + 10000)
                            .sourceCode(sourceCode)
                            .submittedAt(LocalDateTime.now())
                            .passedTestCount(verdict.equals("Accepted") ? "All" : String.valueOf(random.nextInt(20) + 1))
                            .build();

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
