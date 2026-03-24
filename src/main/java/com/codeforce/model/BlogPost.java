package com.codeforce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "blog_posts")
public class BlogPost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "LONGTEXT")
    private String content;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id", nullable = false)
    private User author;

    @Column(nullable = false)
    private Integer upvotes = 0;

    @Column(nullable = false)
    private Integer downvotes = 0;

    @Column(nullable = false)
    private Integer commentCount = 0;

    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column
    private LocalDateTime updatedAt;

    @Column(length = 500)
    private String tags;

    public BlogPost() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public User getAuthor() { return author; }
    public void setAuthor(User author) { this.author = author; }
    public Integer getUpvotes() { return upvotes; }
    public void setUpvotes(Integer upvotes) { this.upvotes = upvotes; }
    public Integer getDownvotes() { return downvotes; }
    public void setDownvotes(Integer downvotes) { this.downvotes = downvotes; }
    public Integer getCommentCount() { return commentCount; }
    public void setCommentCount(Integer commentCount) { this.commentCount = commentCount; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public Integer getScore() {
        return upvotes - downvotes;
    }

    public static BlogPostBuilder builder() {
        return new BlogPostBuilder();
    }

    public static class BlogPostBuilder {
        private String title;
        private String content;
        private User author;
        private Integer upvotes = 0;
        private Integer downvotes = 0;
        private Integer commentCount = 0;
        private LocalDateTime createdAt = LocalDateTime.now();
        private String tags;

        public BlogPostBuilder title(String title) { this.title = title; return this; }
        public BlogPostBuilder content(String content) { this.content = content; return this; }
        public BlogPostBuilder author(User author) { this.author = author; return this; }
        public BlogPostBuilder upvotes(Integer upvotes) { this.upvotes = upvotes; return this; }
        public BlogPostBuilder downvotes(Integer downvotes) { this.downvotes = downvotes; return this; }
        public BlogPostBuilder commentCount(Integer commentCount) { this.commentCount = commentCount; return this; }
        public BlogPostBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public BlogPostBuilder tags(String tags) { this.tags = tags; return this; }

        public BlogPost build() {
            BlogPost post = new BlogPost();
            post.setTitle(title);
            post.setContent(content);
            post.setAuthor(author);
            post.setUpvotes(upvotes);
            post.setDownvotes(downvotes);
            post.setCommentCount(commentCount);
            post.setCreatedAt(createdAt);
            post.setTags(tags);
            return post;
        }
    }
}
