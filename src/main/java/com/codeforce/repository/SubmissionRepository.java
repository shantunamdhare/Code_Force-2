package com.codeforce.repository;

import com.codeforce.model.Submission;
import com.codeforce.model.User;
import com.codeforce.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SubmissionRepository extends JpaRepository<Submission, Long> {
    List<Submission> findByUserOrderBySubmittedAtDesc(User user);
    List<Submission> findByProblemOrderBySubmittedAtDesc(Problem problem);
    List<Submission> findByUserAndVerdict(User user, String verdict);
    List<Submission> findTop20ByOrderBySubmittedAtDesc();
    long countByUser(User user);
    long countByUserAndVerdict(User user, String verdict);
}
