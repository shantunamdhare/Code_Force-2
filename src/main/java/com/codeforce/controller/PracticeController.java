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

    public static class TopicData {
        private String name;
        private String description;
        private String icon;
        private int progress;

        public TopicData(String name, String description, String icon, int progress) {
            this.name = name;
            this.description = description;
            this.icon = icon;
            this.progress = progress;
        }
        public String getName() { return name; }
        public String getDescription() { return description; }
        public String getIcon() { return icon; }
        public int getProgress() { return progress; }
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
        
        // Topic data
        String[] topicNames = {"Arrays", "Trees", "DP", "Graphs", "Math", "Strings"};
        String[] descriptions = {
            "Foundational data structures",
            "Recursive hierarchical logic",
            "Advanced optimization",
            "Network & connectivity",
            "Number theory & combinatorics",
            "Parsing & logic"
        };
        String[] icons = {
            "ph-brackets-square",
            "ph-tree-structure",
            "ph-cube",
            "ph-graph",
            "ph-function",
            "ph-text-t"
        };

        // Cache solved problem IDs to avoid O(N*M) lookups in DB
        java.util.Set<Long> solvedProblemIds = submissionService.getUserSubmissions(currentUser).stream()
                .filter(s -> "Accepted".equals(s.getVerdict()))
                .map(s -> s.getProblem().getId())
                .collect(java.util.stream.Collectors.toSet());

        java.util.List<TopicData> topics = new java.util.ArrayList<>();
        for (int i = 0; i < topicNames.length; i++) {
            String topicName = topicNames[i];
            List<com.codeforce.model.Problem> topicProblems = problemService.findByTag(topicName);
            long totalTopicProblems = topicProblems.size();
            long solvedInTopic = topicProblems.stream()
                    .filter(p -> solvedProblemIds.contains(p.getId()))
                    .count();
            
            int progress = totalTopicProblems > 0 ? (int)((double)solvedInTopic / totalTopicProblems * 100) : 0;
            topics.add(new TopicData(topicName, descriptions[i], icons[i], progress));
        }

        model.addAttribute("totalSolved", totalSolved);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        model.addAttribute("streak", 5);
        model.addAttribute("topics", topics);
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
