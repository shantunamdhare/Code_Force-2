package com.codeforce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "problems")
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

    @Column(nullable = false)
    private Integer timeLimitMs = 2000;

    @Column(nullable = false)
    private Integer memoryLimitMb = 256;

    @Column(nullable = false)
    private Integer difficultyRating;

    @Column(nullable = false)
    private Integer solvedCount = 0;

    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "problem_tags",
        joinColumns = @JoinColumn(name = "problem_id"),
        inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    private Set<Tag> tags = new HashSet<>();

    @Column(nullable = false, length = 20)
    private String status = "APPROVED";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tester_id")
    private User tester;

    public Problem() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getContestId() { return contestId; }
    public void setContestId(String contestId) { this.contestId = contestId; }
    public String getIndexLetter() { return indexLetter; }
    public void setIndexLetter(String indexLetter) { this.indexLetter = indexLetter; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getStatement() { return statement; }
    public void setStatement(String statement) { this.statement = statement; }
    public String getInputSpec() { return inputSpec; }
    public void setInputSpec(String inputSpec) { this.inputSpec = inputSpec; }
    public String getOutputSpec() { return outputSpec; }
    public void setOutputSpec(String outputSpec) { this.outputSpec = outputSpec; }
    public String getSampleInput() { return sampleInput; }
    public void setSampleInput(String sampleInput) { this.sampleInput = sampleInput; }
    public String getSampleOutput() { return sampleOutput; }
    public void setSampleOutput(String sampleOutput) { this.sampleOutput = sampleOutput; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public Integer getTimeLimitMs() { return timeLimitMs; }
    public void setTimeLimitMs(Integer timeLimitMs) { this.timeLimitMs = timeLimitMs; }
    public Integer getMemoryLimitMb() { return memoryLimitMb; }
    public void setMemoryLimitMb(Integer memoryLimitMb) { this.memoryLimitMb = memoryLimitMb; }
    public Integer getDifficultyRating() { return difficultyRating; }
    public void setDifficultyRating(Integer difficultyRating) { this.difficultyRating = difficultyRating; }
    public Integer getSolvedCount() { return solvedCount; }
    public void setSolvedCount(Integer solvedCount) { this.solvedCount = solvedCount; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public Set<Tag> getTags() { return tags; }
    public void setTags(Set<Tag> tags) { this.tags = tags; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public User getTester() { return tester; }
    public void setTester(User tester) { this.tester = tester; }

    public String getFullId() {
        return contestId + indexLetter;
    }

    public String getDifficultyColor() {
        if (difficultyRating == null) return "#808080";
        if (difficultyRating >= 2400) return "#FF0000";
        if (difficultyRating >= 2100) return "#FF8C00";
        if (difficultyRating >= 1900) return "#AA00AA";
        if (difficultyRating >= 1600) return "#0000FF";
        if (difficultyRating >= 1400) return "#03A89E";
        if (difficultyRating >= 1200) return "#008000";
        return "#808080";
    }
}
