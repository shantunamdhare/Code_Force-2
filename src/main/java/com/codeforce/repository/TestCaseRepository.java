package com.codeforce.repository;

import com.codeforce.model.TestCase;
import com.codeforce.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TestCaseRepository extends JpaRepository<TestCase, Long> {
    List<TestCase> findByProblem(Problem problem);
}
