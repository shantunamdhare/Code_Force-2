package com.codeforce.repository;

import com.codeforce.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProblemRepository extends JpaRepository<Problem, Long> {
    List<Problem> findByContestId(String contestId);
    List<Problem> findAllByOrderByDifficultyRatingAsc();
    List<Problem> findByDifficultyRatingBetween(Integer min, Integer max);
    List<Problem> findByNameContainingIgnoreCase(String name);
    List<Problem> findByTags_NameIgnoreCase(String tagName);
}
