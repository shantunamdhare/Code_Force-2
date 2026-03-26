package com.codeforce.controller;

import com.codeforce.model.Problem;
import com.codeforce.model.User;
import com.codeforce.service.ProblemService;
import com.codeforce.service.SubmissionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/practice")
public class PracticeController {

    private final ProblemService problemService;
    private final SubmissionService submissionService;

    @Autowired
    public PracticeController(ProblemService problemService, SubmissionService submissionService) {
        this.problemService = problemService;
        this.submissionService = submissionService;
    }

    @GetMapping
    public String dashboard(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Analytics
        long totalSolved = submissionService.countAcceptedByUser(currentUser);
        long totalSubmissions = submissionService.countByUser(currentUser);
        double accuracy = totalSubmissions > 0 ? (double) totalSolved / totalSubmissions * 100 : 0;
        
        // Topic progress (Simplified calculation: count problems with these tags that are solved)
        String[] topics = {"Math", "Implementation", "DP", "Greedy", "Data Structures", "Graphs", "Strings"};
        Map<String, Integer> topicProgress = new java.util.HashMap<>();
        for (String topic : topics) {
            // This is just a mockup progress value for demonstration
            topicProgress.put(topic, (int) (Math.random() * 100));
        }

        model.addAttribute("totalSolved", totalSolved);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        model.addAttribute("streak", 5); // Mock streak
        model.addAttribute("topicProgress", topicProgress);
        model.addAttribute("recommendations", problemService.getRecommendedProblems(currentUser));
        model.addAttribute("currentUser", currentUser);

        return "practice";
    }

    @GetMapping("/{topic}")
    public String topicDetail(@PathVariable String topic,
                              @RequestParam(defaultValue = "all") String difficulty,
                              HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Problem> problems = problemService.getProblemsByTopicAndDifficulty(topic, difficulty);
        
        // Mark solved problems
        List<Long> solvedProblemIds = submissionService.getUserSubmissions(currentUser).stream()
                .filter(s -> "Accepted".equals(s.getVerdict()))
                .map(s -> s.getProblem().getId())
                .collect(Collectors.toList());

        model.addAttribute("topic", topic);
        model.addAttribute("difficulty", difficulty);
        model.addAttribute("problems", problems);
        model.addAttribute("solvedProblemIds", solvedProblemIds);
        model.addAttribute("currentUser", currentUser);

        return "practice-topic";
    }
}
