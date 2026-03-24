package com.codeforce.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "submissions")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
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

    @Builder.Default
    @Column(nullable = false)
    private Integer timeConsumedMs = 0;

    @Builder.Default
    @Column(nullable = false)
    private Integer memoryConsumedKb = 0;

    @Column(columnDefinition = "LONGTEXT")
    private String sourceCode;

    @Builder.Default
    @Column(nullable = false)
    private LocalDateTime submittedAt = LocalDateTime.now();

    @Column(length = 50)
    private String passedTestCount;

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
