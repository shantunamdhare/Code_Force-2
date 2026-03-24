package com.codeforce.repository;

import com.codeforce.model.TesterFeedback;
import com.codeforce.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface TesterFeedbackRepository extends JpaRepository<TesterFeedback, Long> {
    Optional<TesterFeedback> findByProblem(Problem problem);
}
