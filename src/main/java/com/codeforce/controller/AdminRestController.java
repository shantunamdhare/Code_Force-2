package com.codeforce.controller;

import com.codeforce.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminRestController {

    private final UserService userService;
    private final com.codeforce.service.ContestService contestService;

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getStats() {
        return ResponseEntity.ok(userService.getDashboardStats());
    }

    @PostMapping("/ban")
    public ResponseEntity<String> banUser(@RequestParam Long userId, @RequestParam String duration) {
        userService.banUser(userId, duration);
        return ResponseEntity.ok("User banned successfully");
    }

    @PostMapping("/warn")
    public ResponseEntity<String> warnUser(@RequestParam Long userId, @RequestParam String message) {
        userService.warnUser(userId, message);
        return ResponseEntity.ok("Warning sent successfully");
    }

    @PostMapping("/coordinate-testing")
    public ResponseEntity<String> coordinateTesting(@RequestParam Long contestId) {
        userService.coordinateTesting(contestId);
        return ResponseEntity.ok("Coordination request sent");
    }

    @PostMapping("/publish-contest")
    public ResponseEntity<String> publishContest(@RequestBody Map<String, String> contestData) {
        try {
            com.codeforce.model.Contest contest = com.codeforce.model.Contest.builder()
                .name(contestData.get("title"))
                .startTime(java.time.LocalDateTime.parse(contestData.get("startTime")))
                .durationSeconds(Integer.parseInt(contestData.get("duration")) * 60)
                .type(contestData.getOrDefault("complexity", "Educational"))
                .phase("BEFORE")
                .participantCount(0)
                .preparedBy("Admin")
                .build();
            
            contestService.save(contest);
            return ResponseEntity.ok("Contest '" + contest.getName() + "' published successfully!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error publishing contest: " + e.getMessage());
        }
    }

    @PostMapping("/unban")
    public ResponseEntity<String> unbanUser(@RequestParam Long userId) {
        userService.unbanUser(userId);
        return ResponseEntity.ok("User ban lifted successfully");
    }

    @PostMapping("/update-password")
    public ResponseEntity<String> updatePassword(@RequestBody Map<String, String> data, HttpSession session) {
        com.codeforce.model.User currentUser = (com.codeforce.model.User) session.getAttribute("currentUser");
        if (currentUser == null) return ResponseEntity.status(401).body("Not authenticated");
        
        boolean success = userService.updatePassword(currentUser.getId(), data.get("current"), data.get("new"));
        if (success) {
            return ResponseEntity.ok("Password updated successfully!");
        } else {
            return ResponseEntity.badRequest().body("Incorrect current password!");
        }
    }

    @PostMapping("/investigate")
    public ResponseEntity<String> investigate(@RequestParam String handler) {
        return ResponseEntity.ok("Investigation started for " + handler + ". Scanning logs...");
    }

    @GetMapping("/view-code")
    public ResponseEntity<Map<String, String>> viewCode(@RequestParam String user1, @RequestParam String user2) {
        return ResponseEntity.ok(Map.of(
            "user1Code", "// Code from " + user1 + "\nvoid solve() {\n    int n; cin >> n;\n    // ... Logic ...\n}",
            "user2Code", "// Code from " + user2 + "\nvoid solve() {\n    int n; cin >> n;\n    // ... Similar Logic ...\n}"
        ));
    }

    @GetMapping("/cheating-data")
    public ResponseEntity<?> getCheatingData() {
        return ResponseEntity.ok(userService.detectCheating());
    }
}
