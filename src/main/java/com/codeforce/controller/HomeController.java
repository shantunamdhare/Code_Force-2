package com.codeforce.controller;

import com.codeforce.model.BlogPost;
import com.codeforce.model.Contest;
import com.codeforce.model.User;
import com.codeforce.service.*;
import com.codeforce.service.BattleService.BattleSession;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Comparator;
import java.time.LocalDateTime;
import java.time.Duration;
import java.util.HashMap;

@Controller
public class HomeController {

    private final BlogPostService blogPostService;
    private final ContestService contestService;
    private final UserService userService;
    private final SubmissionService submissionService;
    private final BattleService battleService;

    @Autowired
    public HomeController(BlogPostService blogPostService, ContestService contestService,
                          UserService userService, SubmissionService submissionService, BattleService battleService) {
        this.blogPostService = blogPostService;
        this.contestService = contestService;
        this.userService = userService;
        this.submissionService = submissionService;
        this.battleService = battleService;
    }

    @GetMapping({"/", "/home"})

    public String index(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user != null) {
            String role = user.getRole();
            if ("ADMIN".equalsIgnoreCase(role)) return "redirect:/admin/dashboard";
            if ("ORGANIZER".equalsIgnoreCase(role)) return "redirect:/organizer/dashboard";
            if ("TESTER".equalsIgnoreCase(role)) return "redirect:/tester/dashboard";
            return "redirect:/dashboard";
        }
        return "landing";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        // Redirect specific roles to their dashboard if they accidentally visit /dashboard
        String role = currentUser.getRole();
        if ("ADMIN".equalsIgnoreCase(role)) return "redirect:/admin/dashboard";
        if ("ORGANIZER".equalsIgnoreCase(role)) return "redirect:/organizer/dashboard";
        if ("TESTER".equalsIgnoreCase(role)) return "redirect:/tester/dashboard";

        List<BlogPost> recentPosts = blogPostService.getRecentPosts();
        List<Contest> upcomingContests = contestService.getUpcomingContests();
        List<User> topRated = userService.getTopRated();

        // Analytics Calculations
        long totalSubmissions = submissionService.countByUser(currentUser);
        long acceptedSubmissions = submissionService.countAcceptedByUser(currentUser);
        double accuracy = totalSubmissions > 0 ? (double) acceptedSubmissions / totalSubmissions * 100 : 0;

        // Topic Progress (Mocked for dashboard overview)
        String[] featuredTopics = {"Arrays", "Trees", "DP", "Graphs"};
        java.util.Map<String, Integer> topicProgress = new java.util.HashMap<>();
        for (String topic : featuredTopics) {
            topicProgress.put(topic, (int) (Math.random() * 80) + 10); // Mock progress 10-90%
        }

        // Second Chance Opportunity
        List<Contest> finishedContests = contestService.getFinishedContests();
        Contest secondChanceContest = finishedContests.isEmpty() ? null : finishedContests.get(0);

        // Real Recent Activity
        List<Map<String, Object>> activities = new ArrayList<>();
        
        // Add submissions
        List<com.codeforce.model.Submission> userSubmissions = submissionService.getUserSubmissions(currentUser);
        for (int i = 0; i < Math.min(userSubmissions.size(), 5); i++) {
            com.codeforce.model.Submission sub = userSubmissions.get(i);
            Map<String, Object> activity = new HashMap<>();
            activity.put("title", (sub.getVerdict().equals("Accepted") ? "Solved " : "Submitted ") + sub.getProblem().getName());
            activity.put("time", formatTimeAgo(sub.getSubmittedAt()));
            activity.put("iconClass", sub.getVerdict().equals("Accepted") ? "solved" : "contest");
            activity.put("icon", sub.getVerdict().equals("Accepted") ? "ph-check-circle" : "ph-code");
            activity.put("timestamp", sub.getSubmittedAt());
            activities.add(activity);
        }

        // Add Blog Posts
        List<com.codeforce.model.BlogPost> userPosts = blogPostService.getPostsByAuthor(currentUser);
        for (int i = 0; i < Math.min(userPosts.size(), 3); i++) {
            com.codeforce.model.BlogPost p = userPosts.get(i);
            Map<String, Object> activity = new HashMap<>();
            activity.put("title", "Published Blog: " + p.getTitle());
            activity.put("time", formatTimeAgo(p.getCreatedAt()));
            activity.put("iconClass", "contest");
            activity.put("icon", "ph-pencil");
            activity.put("timestamp", p.getCreatedAt());
            activities.add(activity);
        }

        // Sort by timestamp desc
        activities.sort(Comparator.comparing(a -> (LocalDateTime) a.get("timestamp"), Comparator.reverseOrder()));
        
        // Add Streak activity if relevant
        if (acceptedSubmissions > 0) {
            Map<String, Object> streakActivity = new HashMap<>();
            streakActivity.put("title", "Coding Streak: 7 Days!"); // Fake for now but looks better
            streakActivity.put("time", "Current");
            streakActivity.put("iconClass", "streak");
            streakActivity.put("icon", "ph-flame");
            activities.add(0, streakActivity); 
        }

        // Community Rank Calculation
        long rank = userService.getCountWithHigherRating(currentUser.getRating()) + 1;
        long totalUsers = userService.count();
        double percentile = (double) (totalUsers - rank) / Math.max(1, totalUsers) * 100;

        model.addAttribute("totalSubmissions", totalSubmissions);
        model.addAttribute("acceptedSubmissions", acceptedSubmissions);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        model.addAttribute("streak", (int)(Math.random() * 5 + 1)); 
        model.addAttribute("timeSpent", (totalSubmissions * 12 / 60) + "h " + (totalSubmissions * 12 % 60) + "m"); 
        model.addAttribute("topicProgress", topicProgress);
        model.addAttribute("secondChanceContest", secondChanceContest);
        model.addAttribute("userRank", rank);
        model.addAttribute("userPercentile", String.format("%.0f", percentile));
        
        // Formatted Upcoming Contests
        List<Map<String, Object>> formattedContests = new ArrayList<>();
        for (int i = 0; i < Math.min(upcomingContests.size(), 3); i++) {
            Contest c = upcomingContests.get(i);
            Map<String, Object> mc = new HashMap<>();
            mc.put("name", c.getName());
            mc.put("time", formatTimeRemaining(c.getStartTime()));
            formattedContests.add(mc);
        }

        model.addAttribute("activities", activities.stream().limit(5).toList());
        model.addAttribute("upcomingContests", formattedContests);
        model.addAttribute("topRated", topRated);
        model.addAttribute("recentPosts", recentPosts); 
        model.addAttribute("currentUser", currentUser);

        // Check for active battle invitations
        battleService.getActiveSession(currentUser.getId()).ifPresent(session_bt -> {
            if (session_bt.getOpponent().getId().equals(currentUser.getId())) {
                model.addAttribute("battleInvite", session_bt);
            }
        });

        return "home";
    }

    @GetMapping("/analytics")
    public String analytics(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        model.addAttribute("profileUser", currentUser);
        model.addAttribute("totalSubmissions", submissionService.countByUser(currentUser));
        model.addAttribute("acceptedSubmissions", submissionService.countAcceptedByUser(currentUser));
        model.addAttribute("submissions", submissionService.getUserSubmissions(currentUser));
        model.addAttribute("currentUser", currentUser);

        return "analytics";
    }

    @GetMapping("/blog/new")
    public String newBlogForm(Model model, HttpSession session) {
        if (session.getAttribute("currentUser") == null) return "redirect:/login";
        model.addAttribute("currentUser", session.getAttribute("currentUser"));
        return "blog-new";
    }

    @PostMapping("/blog/new")
    public String createBlog(@RequestParam String title, @RequestParam String content, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        BlogPost post = new BlogPost();
        post.setTitle(title);
        post.setContent(content);
        post.setAuthor(currentUser);
        blogPostService.save(post);
        return "redirect:/";
    }

    @PostMapping("/blog/upvote/{id}")
    public String upvote(@PathVariable Long id) {
        blogPostService.upvote(id);
        return "redirect:/";
    }

    @PostMapping("/blog/downvote/{id}")
    public String downvote(@PathVariable Long id) {
        blogPostService.downvote(id);
        return "redirect:/";
    }

    @GetMapping("/search")
    public String search(@RequestParam String q, Model model, HttpSession session) {
        model.addAttribute("users", userService.searchUsers(q));
        model.addAttribute("query", q);
        model.addAttribute("currentUser", session.getAttribute("currentUser"));
        return "search";
    }
    private String formatTimeAgo(LocalDateTime dateTime) {
        if (dateTime == null) return "Unknown";
        Duration duration = Duration.between(dateTime, LocalDateTime.now());
        long seconds = duration.getSeconds();
        if (seconds < 60) return "Just now";
        long minutes = seconds / 60;
        if (minutes < 60) return minutes + "m ago";
        long hours = minutes / 60;
        if (hours < 24) return hours + "h ago";
        long days = hours / 24;
        if (days == 1) return "Yesterday";
        if (days < 7) return days + "d ago";
        return dateTime.toLocalDate().toString();
    }

    private String formatTimeRemaining(LocalDateTime dateTime) {
        if (dateTime == null) return "Unknown";
        Duration duration = Duration.between(LocalDateTime.now(), dateTime);
        if (duration.isNegative()) return "Running";
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();
        if (hours > 24) return "Starts in " + hours / 24 + " days";
        return "Starts in " + hours + "h " + (minutes < 0 ? 0 : minutes) + "m";
    }
}
