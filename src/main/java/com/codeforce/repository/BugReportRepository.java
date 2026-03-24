package com.codeforce.repository;

import com.codeforce.model.BugReport;
import com.codeforce.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BugReportRepository extends JpaRepository<BugReport, Long> {
    List<BugReport> findByProblem(Problem problem);
    List<BugReport> findByTester(com.codeforce.model.User tester);
}
