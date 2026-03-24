package com.codeforce.controller;

import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class RatingController {

    private final UserService userService;

    @GetMapping("/rating")
    public String rating(Model model, HttpSession session) {
        model.addAttribute("users", userService.getAllByRating());
        model.addAttribute("currentUser", session.getAttribute("currentUser"));
        return "rating";
    }
}
