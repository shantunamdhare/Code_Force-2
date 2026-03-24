package com.codeforce.repository;

import com.codeforce.model.Problem;
import com.codeforce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProblemRepository extends JpaRepository<Problem, Long> {
    List<Problem> findByContestId(String contestId);
    List<Problem> findByDifficultyRatingBetween(Integer min, Integer max);
    List<Problem> findByNameContainingIgnoreCase(String name);
    List<Problem> findByTags_NameIgnoreCase(String tagName);
    List<Problem> findAllByOrderByDifficultyRatingAsc();
    
    // New methods for Tester Dashboard
    List<Problem> findByTester(User tester);
    List<Problem> findByStatus(String status);
}
