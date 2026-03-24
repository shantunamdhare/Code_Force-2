package com.codeforce.controller;

import com.codeforce.model.User;
import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    private final UserService userService;

    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }

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

        User user = new User();
        user.setHandle(handle.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setFirstName(firstName != null ? firstName.trim() : null);
        user.setLastName(lastName != null ? lastName.trim() : null);
        user.setCountry(country != null ? country.trim() : null);
        user.setCity(city != null ? city.trim() : null);
        user.setOrganization(organization != null ? organization.trim() : null);

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
