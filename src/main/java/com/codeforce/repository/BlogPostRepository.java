package com.codeforce.repository;

import com.codeforce.model.BlogPost;
import com.codeforce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BlogPostRepository extends JpaRepository<BlogPost, Long> {
    List<BlogPost> findAllByOrderByCreatedAtDesc();
    List<BlogPost> findByAuthorOrderByCreatedAtDesc(User author);
    List<BlogPost> findTop10ByOrderByCreatedAtDesc();
    List<BlogPost> findByTitleContainingIgnoreCase(String title);
}
