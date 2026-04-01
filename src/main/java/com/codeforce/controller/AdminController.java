package com.codeforce.controller;

import com.codeforce.model.User;
import com.codeforce.service.UserService;
import com.codeforce.service.ContestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final ContestService contestService;

    public AdminController(UserService userService, ContestService contestService) {
        this.userService = userService;
        this.contestService = contestService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || (!"ADMIN".equals(currentUser.getRole()) && !"ORGANIZER".equalsIgnoreCase(currentUser.getRole()))) {
            return "redirect:/login";
        }

        model.addAttribute("stats", userService.getDashboardStats());
        model.addAttribute("suspiciousUsers", userService.getSuspiciousUsers());
        model.addAttribute("cheatingData", userService.detectCheating());
        model.addAttribute("anomalousData", userService.getAnomalousActivity());
        model.addAttribute("bugReports", userService.getBugReports());
        model.addAttribute("upcomingContests", contestService.getUpcomingContests());
        model.addAttribute("users", userService.findAll());
        return "admin/dashboard";
    }
}
