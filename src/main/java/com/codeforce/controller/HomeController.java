package com.codeforce.controller;

import com.codeforce.model.BlogPost;
import com.codeforce.model.Contest;
import com.codeforce.model.User;
import com.codeforce.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final BlogPostService blogPostService;
    private final ContestService contestService;
    private final UserService userService;
    private final SubmissionService submissionService;

    @GetMapping("/")
    public String index(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/dashboard";
        }
        return "landing";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        List<BlogPost> recentPosts = blogPostService.getRecentPosts();
        List<Contest> upcomingContests = contestService.getUpcomingContests();
        List<User> topRated = userService.getTopRated();

        model.addAttribute("totalSubmissions", submissionService.countByUser(currentUser));
        model.addAttribute("acceptedSubmissions", submissionService.countAcceptedByUser(currentUser));
        model.addAttribute("posts", recentPosts);
        model.addAttribute("upcomingContests", upcomingContests);
        model.addAttribute("topRated", topRated);
        model.addAttribute("currentUser", currentUser);

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

        BlogPost post = BlogPost.builder()
                .title(title)
                .content(content)
                .author(currentUser)
                .build();
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
}
