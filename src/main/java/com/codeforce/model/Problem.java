package com.codeforce.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "problems")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Problem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10)
    private String contestId;

    @Column(nullable = false, length = 5)
    private String indexLetter;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String statement;

    @Column(columnDefinition = "TEXT")
    private String inputSpec;

    @Column(columnDefinition = "TEXT")
    private String outputSpec;

    @Column(columnDefinition = "TEXT")
    private String sampleInput;

    @Column(columnDefinition = "TEXT")
    private String sampleOutput;

    @Column(columnDefinition = "TEXT")
    private String note;

    @Builder.Default
    @Column(nullable = false)
    private Integer timeLimitMs = 2000;

    @Builder.Default
    @Column(nullable = false)
    private Integer memoryLimitMb = 256;

    @Column(nullable = false)
    private Integer difficultyRating;

    @Builder.Default
    @Column(nullable = false)
    private Integer solvedCount = 0;

    @Builder.Default
    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "problem_tags",
        joinColumns = @JoinColumn(name = "problem_id"),
        inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @Builder.Default
    private Set<Tag> tags = new HashSet<>();

    public String getFullId() {
        return contestId + indexLetter;
    }

    public String getDifficultyColor() {
        if (difficultyRating >= 2400) return "#FF0000";
        if (difficultyRating >= 2100) return "#FF8C00";
        if (difficultyRating >= 1900) return "#AA00AA";
        if (difficultyRating >= 1600) return "#0000FF";
        if (difficultyRating >= 1400) return "#03A89E";
        if (difficultyRating >= 1200) return "#008000";
        return "#808080";
    }
}
