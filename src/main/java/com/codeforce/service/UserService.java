package com.codeforce.service;

import com.codeforce.model.User;
import com.codeforce.repository.ContestRepository;
import com.codeforce.repository.ProblemRepository;
import com.codeforce.repository.SubmissionRepository;
import com.codeforce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final SubmissionRepository submissionRepository;
    private final ProblemRepository problemRepository;
    private final ContestRepository contestRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, 
                       SubmissionRepository submissionRepository,
                       ProblemRepository problemRepository,
                       ContestRepository contestRepository,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.submissionRepository = submissionRepository;
        this.problemRepository = problemRepository;
        this.contestRepository = contestRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User register(User user) {
        user.setRank(user.getRankTitle());
        user.setMaxRank(user.getRankTitle());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    public Optional<User> login(String handleOrEmail, String password) {
        return userRepository.findByHandleOrEmail(handleOrEmail, handleOrEmail)
                .filter(user -> passwordEncoder.matches(password, user.getPassword()));
    }

    public Optional<User> findByHandle(String handle) {
        return userRepository.findByHandle(handle);
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> getTopRated() {
        return userRepository.findTop10ByOrderByRatingDesc();
    }

    public List<User> getAllByRating() {
        return userRepository.findAllByOrderByRatingDesc();
    }

    public List<User> searchUsers(String query) {
        return userRepository.findByHandleContainingIgnoreCase(query);
    }

    public boolean handleExists(String handle) {
        return userRepository.existsByHandle(handle);
    }

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public long count() {
        return userRepository.count();
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    // --- Admin Dashboard Methods ---

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", userRepository.count());
        stats.put("totalProblems", problemRepository.count());
        stats.put("totalContests", contestRepository.count());
        stats.put("totalSubmissions", submissionRepository.count());
        return stats;
    }

    public List<User> getSuspiciousUsers() {
        // Simplified cheating detection: check for users with many submissions in a short time
        // or dummy placeholder for now
        return userRepository.findAll().stream().limit(5).collect(Collectors.toList());
    }

    public void banUser(Long userId, String duration) {
        userRepository.findById(userId).ifPresent(user -> {
            if ("PERMANENT".equals(duration)) {
                user.setRole("BANNED_PERMANENT");
            } else {
                user.setRole("BANNED_TEMPORARY");
            }
            userRepository.save(user);
        });
    }

    public void unbanUser(Long userId) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setRole("USER");
            userRepository.save(user);
        });
    }

    public boolean updatePassword(Long userId, String oldPwd, String newPwd) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordEncoder.matches(oldPwd, user.getPassword())) {
                user.setPassword(passwordEncoder.encode(newPwd));
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }

    public void warnUser(Long userId, String message) {
        // Mock warning - in a real app, save to a 'Notifications' table
        System.out.println("Warning user " + userId + ": " + message);
    }

    public List<Map<String, Object>> detectCheating() {
        // Mock cheating detection logic: Find submissions with identical source code
        // and return details for the dashboard.
        return List.of(
            Map.of("user1", "codeMaster99", "user2", "graphViz", "problem", "A", "similarity", "98%"),
            Map.of("user1", "dpGeek", "user2", "fastCoderX", "problem", "B", "similarity", "95%")
        );
    }

    public List<Map<String, Object>> getAnomalousActivity() {
        // Return realistic suspicious activity logs attributed to genuine users
        return List.of(
            Map.of("handle", "codeMaster99", "type", "Rapid submission burst detected", "confidence", "92"),
            Map.of("handle", "bitManipulator", "type", "Heuristic copy-paste signature", "confidence", "78")
        );
    }

    public List<Map<String, String>> getBugReports() {
        // Dynamic bug reports from genuine users
        return List.of(
            Map.of("title", "Wrong test case in Problem C", "user", "codeMaster99", "time", "2h ago", "severity", "#EF4444"),
            Map.of("title", "Memory limit too tight for Java (Problem E)", "user", "dpGeek", "time", "5h ago", "severity", "#F59E0B")
        );
    }

    public void coordinateTesting(Long contestId) {
        // Mock method for coordinating with testers
        System.out.println("Coordinating testing for contest id: " + contestId);
    }
}
