package com.codeforce.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tags")
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 100)
    private String name;

    @Column(nullable = false)
    private Integer problemCount = 0;

    public Tag() {}

    public Tag(String name, Integer problemCount) {
        this.name = name;
        this.problemCount = problemCount;
    }

    public static TagBuilder builder() {
        return new TagBuilder();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Integer getProblemCount() { return problemCount; }
    public void setProblemCount(Integer problemCount) { this.problemCount = problemCount; }

    public static class TagBuilder {
        private String name;
        private Integer problemCount = 0;

        public TagBuilder name(String name) {
            this.name = name;
            return this;
        }

        public TagBuilder problemCount(Integer problemCount) {
            this.problemCount = problemCount;
            return this;
        }

        public Tag build() {
            return new Tag(name, problemCount);
        }
    }
}
