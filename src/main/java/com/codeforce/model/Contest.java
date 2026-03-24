package com.codeforce.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "contests")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Contest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private String phase;

    @Column(nullable = false)
    private Integer durationSeconds;

    @Column(nullable = false)
    private LocalDateTime startTime;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Builder.Default
    @Column(nullable = false)
    private Integer participantCount = 0;

    @Column(length = 200)
    private String preparedBy;

    @Column(length = 200)
    private String websiteUrl;

    public String getFormattedDuration() {
        int hours = durationSeconds / 3600;
        int minutes = (durationSeconds % 3600) / 60;
        return String.format("%02d:%02d", hours, minutes);
    }

    public String getPhaseColor() {
        return switch (phase) {
            case "BEFORE" -> "#E67E22";
            case "CODING" -> "#27AE60";
            case "FINISHED" -> "#95A5A6";
            default -> "#3498DB";
        };
    }

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "contest_participants",
        joinColumns = @JoinColumn(name = "contest_id"),
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    @Builder.Default
    private java.util.Set<User> participants = new java.util.HashSet<>();

    public String getPhaseLabel() {
        return switch (phase) {
            case "BEFORE" -> "Upcoming";
            case "CODING" -> "Running";
            case "FINISHED" -> "Finished";
            default -> phase;
        };
    }
}
