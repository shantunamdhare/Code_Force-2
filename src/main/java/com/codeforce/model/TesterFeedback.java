package com.codeforce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tester_feedback")
public class TesterFeedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    private Problem problem;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tester_id", nullable = false)
    private User tester;

    @Column(nullable = false, length = 20)
    private String suggestedDifficulty; // EASY, MEDIUM, HARD

    @Column(columnDefinition = "TEXT")
    private String comment;

    @Column(nullable = false)
    private boolean isFair = true;

    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public TesterFeedback() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Problem getProblem() { return problem; }
    public void setProblem(Problem problem) { this.problem = problem; }
    public User getTester() { return tester; }
    public void setTester(User tester) { this.tester = tester; }
    public String getSuggestedDifficulty() { return suggestedDifficulty; }
    public void setSuggestedDifficulty(String suggestedDifficulty) { this.suggestedDifficulty = suggestedDifficulty; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public boolean isFair() { return isFair; }
    public void setFair(boolean isFair) { this.isFair = isFair; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
