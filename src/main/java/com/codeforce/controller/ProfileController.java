package com.codeforce.controller;

import com.codeforce.model.User;
import com.codeforce.service.SubmissionService;
import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ProfileController {

    private final UserService userService;
    private final SubmissionService submissionService;

    public ProfileController(UserService userService, SubmissionService submissionService) {
        this.userService = userService;
        this.submissionService = submissionService;
    }

    @GetMapping("/profile/{handle}")
    public String profile(@PathVariable String handle, Model model, HttpSession session) {
        return userService.findByHandle(handle)
                .map(user -> {
                    model.addAttribute("profileUser", user);
                    model.addAttribute("totalSubmissions", submissionService.countByUser(user));
                    model.addAttribute("acceptedSubmissions", submissionService.countAcceptedByUser(user));
                    model.addAttribute("submissions", submissionService.getUserSubmissions(user));
                    model.addAttribute("currentUser", session.getAttribute("currentUser"));
                    return "profile";
                })
                .orElse("redirect:/");
    }
}
