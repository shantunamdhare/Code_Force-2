package com.codeforce.controller;

import com.codeforce.model.User;
import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @GetMapping("/login")
    public String loginPage(Model model, HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String handle, @RequestParam String password,
                        HttpSession session, RedirectAttributes redirectAttributes) {
        return userService.login(handle.trim(), password.trim())
                .map(user -> {
                    session.setAttribute("currentUser", user);
                    return "redirect:/";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Invalid handle or password");
                    return "redirect:/login";
                });
    }

    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String handle, @RequestParam String email,
                           @RequestParam String password, @RequestParam String confirmPassword,
                           @RequestParam(required = false) String firstName,
                           @RequestParam(required = false) String lastName,
                           @RequestParam(required = false) String country,
                           @RequestParam(required = false) String city,
                           @RequestParam(required = false) String organization,
                           HttpSession session, RedirectAttributes redirectAttributes) {
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/register";
        }

        if (userService.handleExists(handle)) {
            redirectAttributes.addFlashAttribute("error", "Handle already taken");
            return "redirect:/register";
        }

        if (userService.emailExists(email)) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            return "redirect:/register";
        }

        User user = User.builder()
                .handle(handle.trim())
                .email(email.trim())
                .password(password.trim())
                .firstName(firstName != null ? firstName.trim() : null)
                .lastName(lastName != null ? lastName.trim() : null)
                .country(country != null ? country.trim() : null)
                .city(city != null ? city.trim() : null)
                .organization(organization != null ? organization.trim() : null)
                .build();

        user = userService.register(user);
        session.setAttribute("currentUser", user);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
