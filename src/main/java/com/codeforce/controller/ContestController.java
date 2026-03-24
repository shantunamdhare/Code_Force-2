package com.codeforce.controller;

import com.codeforce.model.Contest;
import com.codeforce.model.User;
import com.codeforce.service.ContestService;
import com.codeforce.service.ProblemService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/contests")
@RequiredArgsConstructor
public class ContestController {

    private final ContestService contestService;
    private final ProblemService problemService;

    @GetMapping
    public String contests(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        List<Contest> upcomingContests = contestService.getUpcomingContests();
        List<Contest> runningContests = contestService.getRunningContests();
        List<Contest> finishedContests = contestService.getFinishedContests();

        if (currentUser != null) {
            List<Contest> myContests = upcomingContests.stream()
                .filter(c -> c.getParticipants().stream().anyMatch(u -> u.getId().equals(currentUser.getId())))
                .toList();
            model.addAttribute("myContests", myContests);
            
            // Filter upcoming so they don't appear twice (optional, but cleaner)
            upcomingContests = upcomingContests.stream()
                .filter(c -> c.getParticipants().stream().noneMatch(u -> u.getId().equals(currentUser.getId())))
                .toList();
        }

        model.addAttribute("upcomingContests", upcomingContests);
        model.addAttribute("runningContests", runningContests);
        model.addAttribute("finishedContests", finishedContests);
        model.addAttribute("currentUser", currentUser);

        return "contests";
    }

    @GetMapping("/{id}")
    public String contestDetail(@PathVariable Long id, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        return contestService.findById(id)
                .map(contest -> {
                    model.addAttribute("contest", contest);
                    model.addAttribute("currentUser", currentUser);
                    if (currentUser != null) {
                        boolean registered = contest.getParticipants().stream()
                                .anyMatch(u -> u.getId().equals(currentUser.getId()));
                        model.addAttribute("registered", registered);
                    }
                    return "contest-detail";
                })
                .orElse("redirect:/contests");
    }

    @PostMapping("/register/{id}")
    public String registerForContest(@PathVariable Long id, HttpSession session, 
                                   org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        
        return contestService.findById(id).map(contest -> {
            boolean alreadyRegistered = contest.getParticipants().stream()
                    .anyMatch(u -> u.getId().equals(currentUser.getId()));
            
            if (!alreadyRegistered) {
                contest.getParticipants().add(currentUser);
                contest.setParticipantCount(contest.getParticipants().size());
                contestService.save(contest);
                redirectAttributes.addFlashAttribute("success", "Successfully registered for " + contest.getName());
            } else {
                redirectAttributes.addFlashAttribute("info", "You are already registered for this contest.");
            }
            return "redirect:/contests/" + id;
        }).orElse("redirect:/contests");
    }

    @GetMapping("/battle")
    public String battleArena(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        model.addAttribute("currentUser", currentUser);
        return "battle";
    }
}
