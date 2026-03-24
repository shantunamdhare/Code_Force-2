package com.codeforce.service;

import com.codeforce.model.BlogPost;
import com.codeforce.model.User;
import com.codeforce.repository.BlogPostRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BlogPostService {

    private final BlogPostRepository blogPostRepository;

    public BlogPostService(BlogPostRepository blogPostRepository) {
        this.blogPostRepository = blogPostRepository;
    }

    public List<BlogPost> getAllPosts() {
        return blogPostRepository.findAllByOrderByCreatedAtDesc();
    }

    public List<BlogPost> getRecentPosts() {
        return blogPostRepository.findTop10ByOrderByCreatedAtDesc();
    }

    public Optional<BlogPost> findById(Long id) {
        return blogPostRepository.findById(id);
    }

    public List<BlogPost> getPostsByAuthor(User author) {
        return blogPostRepository.findByAuthorOrderByCreatedAtDesc(author);
    }

    public BlogPost save(BlogPost blogPost) {
        return blogPostRepository.save(blogPost);
    }

    public void upvote(Long id) {
        blogPostRepository.findById(id).ifPresent(post -> {
            post.setUpvotes(post.getUpvotes() + 1);
            blogPostRepository.save(post);
        });
    }

    public void downvote(Long id) {
        blogPostRepository.findById(id).ifPresent(post -> {
            post.setDownvotes(post.getDownvotes() + 1);
            blogPostRepository.save(post);
        });
    }
}
