package com.codeforce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

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

    @Column(nullable = false)
    private Integer rating = 0;

    @Column(nullable = false)
    private Integer maxRating = 0;

    @Column(name = "user_rank", length = 50)
    private String rank;

    @Column(name = "max_user_rank", length = 50)
    private String maxRank;

    @Column(nullable = false)
    private Integer contribution = 0;

    @Column(nullable = false)
    private Integer friendCount = 0;

    @Column(nullable = false)
    private LocalDateTime registrationTime = LocalDateTime.now();

    @Column(length = 500)
    private String avatarUrl;

    @Column(name = "role", nullable = false)
    private String role = "USER";

    public User() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getHandle() { return handle; }
    public void setHandle(String handle) { this.handle = handle; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    public String getOrganization() { return organization; }
    public void setOrganization(String organization) { this.organization = organization; }
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    public Integer getMaxRating() { return maxRating; }
    public void setMaxRating(Integer maxRating) { this.maxRating = maxRating; }
    public String getRank() { return rank; }
    public void setRank(String rank) { this.rank = rank; }
    public String getMaxRank() { return maxRank; }
    public void setMaxRank(String maxRank) { this.maxRank = maxRank; }
    public Integer getContribution() { return contribution; }
    public void setContribution(Integer contribution) { this.contribution = contribution; }
    public Integer getFriendCount() { return friendCount; }
    public void setFriendCount(Integer friendCount) { this.friendCount = friendCount; }
    public LocalDateTime getRegistrationTime() { return registrationTime; }
    public void setRegistrationTime(LocalDateTime registrationTime) { this.registrationTime = registrationTime; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public static UserBuilder builder() {
        return new UserBuilder();
    }

    public static class UserBuilder {
        private String handle;
        private String email;
        private String password;
        private String firstName;
        private String lastName;
        private String city;
        private String country;
        private String organization;
        private Integer rating = 0;
        private Integer maxRating = 0;
        private String rank;
        private String maxRank;
        private Integer contribution = 0;
        private Integer friendCount = 0;
        private LocalDateTime registrationTime = LocalDateTime.now();
        private String avatarUrl;
        private String role = "USER";

        public UserBuilder handle(String handle) { this.handle = handle; return this; }
        public UserBuilder email(String email) { this.email = email; return this; }
        public UserBuilder password(String password) { this.password = password; return this; }
        public UserBuilder firstName(String firstName) { this.firstName = firstName; return this; }
        public UserBuilder lastName(String lastName) { this.lastName = lastName; return this; }
        public UserBuilder city(String city) { this.city = city; return this; }
        public UserBuilder country(String country) { this.country = country; return this; }
        public UserBuilder organization(String organization) { this.organization = organization; return this; }
        public UserBuilder rating(Integer rating) { this.rating = rating; return this; }
        public UserBuilder maxRating(Integer maxRating) { this.maxRating = maxRating; return this; }
        public UserBuilder rank(String rank) { this.rank = rank; return this; }
        public UserBuilder maxRank(String maxRank) { this.maxRank = maxRank; return this; }
        public UserBuilder contribution(Integer contribution) { this.contribution = contribution; return this; }
        public UserBuilder friendCount(Integer friendCount) { this.friendCount = friendCount; return this; }
        public UserBuilder registrationTime(LocalDateTime regTime) { this.registrationTime = regTime; return this; }
        public UserBuilder avatarUrl(String url) { this.avatarUrl = url; return this; }
        public UserBuilder role(String role) { this.role = role; return this; }

        public User build() {
            User user = new User();
            user.setHandle(handle);
            user.setEmail(email);
            user.setPassword(password);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setCity(city);
            user.setCountry(country);
            user.setOrganization(organization);
            user.setRating(rating);
            user.setMaxRating(maxRating);
            user.setRank(rank);
            user.setMaxRank(maxRank);
            user.setContribution(contribution);
            user.setFriendCount(friendCount);
            user.setRegistrationTime(registrationTime);
            user.setAvatarUrl(avatarUrl);
            user.setRole(role);
            return user;
        }
    }

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
