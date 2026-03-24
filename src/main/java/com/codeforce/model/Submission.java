package com.codeforce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "submissions")
public class Submission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "problem_id", nullable = false)
    private Problem problem;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "contest_id")
    private Contest contest;

    @Column(nullable = false, length = 50)
    private String programmingLanguage;

    @Column(nullable = false)
    private String verdict;

    @Column(nullable = false)
    private Integer timeConsumedMs = 0;

    @Column(nullable = false)
    private Integer memoryConsumedKb = 0;

    @Column(columnDefinition = "LONGTEXT")
    private String sourceCode;

    @Column(nullable = false)
    private LocalDateTime submittedAt = LocalDateTime.now();

    @Column(length = 50)
    private String passedTestCount;

    public Submission() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Problem getProblem() { return problem; }
    public void setProblem(Problem problem) { this.problem = problem; }
    public Contest getContest() { return contest; }
    public void setContest(Contest contest) { this.contest = contest; }
    public String getProgrammingLanguage() { return programmingLanguage; }
    public void setProgrammingLanguage(String programmingLanguage) { this.programmingLanguage = programmingLanguage; }
    public String getVerdict() { return verdict; }
    public void setVerdict(String verdict) { this.verdict = verdict; }
    public Integer getTimeConsumedMs() { return timeConsumedMs; }
    public void setTimeConsumedMs(Integer timeConsumedMs) { this.timeConsumedMs = timeConsumedMs; }
    public Integer getMemoryConsumedKb() { return memoryConsumedKb; }
    public void setMemoryConsumedKb(Integer memoryConsumedKb) { this.memoryConsumedKb = memoryConsumedKb; }
    public String getSourceCode() { return sourceCode; }
    public void setSourceCode(String sourceCode) { this.sourceCode = sourceCode; }
    public LocalDateTime getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(LocalDateTime submittedAt) { this.submittedAt = submittedAt; }
    public String getPassedTestCount() { return passedTestCount; }
    public void setPassedTestCount(String passedTestCount) { this.passedTestCount = passedTestCount; }

    public String getVerdictColor() {
        return switch (verdict) {
            case "Accepted" -> "#27AE60";
            case "Wrong Answer" -> "#E74C3C";
            case "Time Limit Exceeded" -> "#E67E22";
            case "Memory Limit Exceeded" -> "#9B59B6";
            case "Runtime Error" -> "#E74C3C";
            case "Compilation Error" -> "#F39C12";
            default -> "#95A5A6";
        };
    }

    public String getVerdictShort() {
        return switch (verdict) {
            case "Accepted" -> "AC";
            case "Wrong Answer" -> "WA";
            case "Time Limit Exceeded" -> "TLE";
            case "Memory Limit Exceeded" -> "MLE";
            case "Runtime Error" -> "RE";
            case "Compilation Error" -> "CE";
            default -> verdict;
        };
    }
}
