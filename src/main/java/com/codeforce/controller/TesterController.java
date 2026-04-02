package com.codeforce.controller;

import com.codeforce.model.*;
import com.codeforce.service.TesterService;
import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("/tester")
public class TesterController {

    private final TesterService testerService;
    private final UserService userService;

    @Autowired
    public TesterController(TesterService testerService, UserService userService) {
        this.testerService = testerService;
        this.userService = userService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        
        if (!"TESTER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            return "redirect:/";
        }
        
        model.addAttribute("pendingProblems", testerService.getPendingProblems());
        model.addAttribute("allProblems", testerService.getAllProblems());
        if (currentUser != null) {
            model.addAttribute("assignedProblems", testerService.getAssignedProblems(currentUser));
            model.addAttribute("bugReports", testerService.getBugReportsByTester(currentUser));
        }
        model.addAttribute("currentUser", currentUser);
        return "tester-dashboard";
    }

    @PostMapping("/login")
    public String testerLogin(@RequestParam String username, @RequestParam String password, 
                               HttpSession session, RedirectAttributes redirectAttributes) {
        return userService.login(username, password)
                .map(user -> {
                    if (!"TESTER".equalsIgnoreCase(user.getRole()) && !"ADMIN".equalsIgnoreCase(user.getRole())) {
                        redirectAttributes.addFlashAttribute("error", "Access denied. This portal is for testers only.");
                        return "redirect:/tester/quick-access";
                    }
                    session.setAttribute("currentUser", user);
                    
                    // Set authentication in SecurityContext
                    org.springframework.security.core.Authentication auth = 
                        new org.springframework.security.authentication.UsernamePasswordAuthenticationToken(
                            user.getHandle(), null, 
                            java.util.Collections.singletonList(new org.springframework.security.core.authority.SimpleGrantedAuthority("ROLE_" + user.getRole()))
                        );
                    org.springframework.security.core.context.SecurityContextHolder.getContext().setAuthentication(auth);
                    
                    return "redirect:/tester/dashboard";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Invalid tester credentials. Please try again.");
                    return "redirect:/tester/quick-access";
                });
    }

    @GetMapping("/quick-access")
    public String quickAccess(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        // If already logged in as TESTER or ADMIN, go straight to dashboard
        if (currentUser != null && 
            ("TESTER".equalsIgnoreCase(currentUser.getRole()) || "ADMIN".equalsIgnoreCase(currentUser.getRole()))) {
            return "redirect:/tester/dashboard";
        }
        return "tester-login";
    }

    @PostMapping("/dashboard/bug")
    public String reportBugFromDashboard(@RequestParam Long problemId, @RequestParam String description,
                                         @RequestParam String severity, HttpSession session,
                                         RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/tester/dashboard";

        testerService.reportBug(problemId, currentUser, description, severity);
        redirectAttributes.addFlashAttribute("bugSuccess", "Bug reported successfully!");
        return "redirect:/tester/dashboard";
    }

    @PostMapping("/assign/{id}")
    public String assign(@PathVariable Long id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        testerService.assignProblem(id, currentUser);
        return "redirect:/tester/problem/" + id;
    }

    @GetMapping("/problem/{id}")
    public String problemDetail(@PathVariable Long id, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        if (!"TESTER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            return "redirect:/";
        }

        return testerService.getProblem(id)
                .map(problem -> {
                    model.addAttribute("problem", problem);
                    model.addAttribute("testCases", testerService.getTestCases(id));
                    model.addAttribute("currentUser", currentUser);
                    return "tester-problem-detail";
                })
                .orElse("redirect:/tester/dashboard");
    }

    @PostMapping("/problem/{id}/test")
    @ResponseBody
    public Map<String, Object> runTest(@PathVariable Long id, @RequestBody Map<String, String> payload) {
        String input = payload.get("input");
        // Simulate execution
        Map<String, Object> result = new HashMap<>();
        result.put("output", "Simulated output for: " + input);
        result.put("time", new Random().nextInt(500) + "ms");
        result.put("memory", new Random().nextInt(50) + "MB");
        return result;
    }

    @PostMapping("/problem/{id}/bug")
    public String reportBug(@PathVariable Long id, @RequestParam String description, 
                            @RequestParam String severity, HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        testerService.reportBug(id, currentUser, description, severity);
        redirectAttributes.addFlashAttribute("success", "Bug reported successfully.");
        return "redirect:/tester/problem/" + id;
    }

    @PostMapping("/problem/{id}/feedback")
    public String submitFeedback(@PathVariable Long id, @RequestParam String difficulty,
                                 @RequestParam String comment, @RequestParam boolean isFair,
                                 @RequestParam String status, HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        testerService.submitFeedback(id, currentUser, difficulty, comment, isFair, status);
        redirectAttributes.addFlashAttribute("success", "Feedback submitted. Problem marked as " + status);
        return "redirect:/tester/dashboard";
    }
}
