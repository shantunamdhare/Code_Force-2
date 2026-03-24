package com.codeforce.controller;

import com.codeforce.model.Contest;
import com.codeforce.model.Problem;
import com.codeforce.model.User;
import com.codeforce.service.ContestService;
import com.codeforce.service.ProblemService;
import com.codeforce.service.SubmissionService;
import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/organizer")
public class OrganizerController {

    private final ContestService contestService;
    private final ProblemService problemService;
    private final UserService userService;
    private final SubmissionService submissionService;

    public OrganizerController(ContestService contestService, ProblemService problemService, 
                               UserService userService, SubmissionService submissionService) {
        this.contestService = contestService;
        this.problemService = problemService;
        this.userService = userService;
        this.submissionService = submissionService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        
        // Strict role check for organizer suite
        if (!"ORGANIZER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            return "redirect:/"; // Redirect unauthorized users to home
        }

        model.addAttribute("totalContests", contestService.count());
        model.addAttribute("totalProblems", problemService.count());
        model.addAttribute("totalUsers", userService.count());
        model.addAttribute("recentSubmissions", submissionService.getRecentSubmissions());
        model.addAttribute("currentUser", currentUser);
        
        return "organizer-dashboard";
    }

    @GetMapping("/contests")
    public String manageContests(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        if (!"ORGANIZER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            return "redirect:/";
        }
        model.addAttribute("contests", contestService.getAllContests());
        model.addAttribute("currentUser", session.getAttribute("currentUser"));
        return "organizer-contests";
    }

    @GetMapping("/problems")
    public String manageProblems(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        if (!"ORGANIZER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            return "redirect:/";
        }
        model.addAttribute("problems", problemService.getAllProblems());
        model.addAttribute("currentUser", session.getAttribute("currentUser"));
        return "organizer-problems";
    }
}
