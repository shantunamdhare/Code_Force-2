package com.codeforce.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 50)
    private String handle;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(length = 100)
    private String firstName;

    @Column(length = 100)
    private String lastName;

    @Column(length = 100)
    private String city;

    @Column(length = 100)
    private String country;

    @Column(length = 200)
    private String organization;

    @Builder.Default
    @Column(nullable = false)
    private Integer rating = 0;

    @Builder.Default
    @Column(nullable = false)
    private Integer maxRating = 0;

    @Column(name = "user_rank", length = 50)
    private String rank;

    @Column(name = "max_user_rank", length = 50)
    private String maxRank;

    @Builder.Default
    @Column(nullable = false)
    private Integer contribution = 0;

    @Builder.Default
    @Column(nullable = false)
    private Integer friendCount = 0;

    @Builder.Default
    @Column(nullable = false)
    private LocalDateTime registrationTime = LocalDateTime.now();

    @Column(length = 500)
    private String avatarUrl;

    @Builder.Default
    @Column(nullable = false)
    private String role = "USER";

    public String getRankColor() {
        if (rating >= 2400) return "#FF0000";
        if (rating >= 2100) return "#FF8C00";
        if (rating >= 1900) return "#AA00AA";
        if (rating >= 1600) return "#0000FF";
        if (rating >= 1400) return "#03A89E";
        if (rating >= 1200) return "#008000";
        return "#808080";
    }

    public String getRankTitle() {
        if (rating >= 2400) return "Grandmaster";
        if (rating >= 2100) return "Master";
        if (rating >= 1900) return "Candidate Master";
        if (rating >= 1600) return "Expert";
        if (rating >= 1400) return "Specialist";
        if (rating >= 1200) return "Pupil";
        return "Newbie";
    }
}
