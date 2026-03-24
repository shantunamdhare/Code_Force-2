package com.codeforce.service;

import com.codeforce.model.*;
import com.codeforce.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TesterService {

    private final ProblemRepository problemRepository;
    private final BugReportRepository bugReportRepository;
    private final TesterFeedbackRepository testerFeedbackRepository;
    private final TestCaseRepository testCaseRepository;

    @Autowired
    public TesterService(ProblemRepository problemRepository,
                         BugReportRepository bugReportRepository,
                         TesterFeedbackRepository testerFeedbackRepository,
                         TestCaseRepository testCaseRepository) {
        this.problemRepository = problemRepository;
        this.bugReportRepository = bugReportRepository;
        this.testerFeedbackRepository = testerFeedbackRepository;
        this.testCaseRepository = testCaseRepository;
    }

    public List<Problem> getAssignedProblems(User tester) {
        return problemRepository.findByTester(tester);
    }

    public List<Problem> getPendingProblems() {
        return problemRepository.findByStatus("PENDING");
    }

    public void assignProblem(Long problemId, User tester) {
        problemRepository.findById(problemId).ifPresent(problem -> {
            problem.setTester(tester);
            problem.setStatus("TESTING");
            problemRepository.save(problem);
        });
    }

    public void reportBug(Long problemId, User tester, String description, String severity) {
        problemRepository.findById(problemId).ifPresent(problem -> {
            BugReport bug = new BugReport();
            bug.setProblem(problem);
            bug.setTester(tester);
            bug.setDescription(description);
            bug.setSeverity(severity);
            bugReportRepository.save(bug);
        });
    }

    public void submitFeedback(Long problemId, User tester, String difficulty, String comment, boolean isFair, String status) {
        problemRepository.findById(problemId).ifPresent(problem -> {
            TesterFeedback feedback = new TesterFeedback();
            feedback.setProblem(problem);
            feedback.setTester(tester);
            feedback.setSuggestedDifficulty(difficulty);
            feedback.setComment(comment);
            feedback.setFair(isFair);
            testerFeedbackRepository.save(feedback);

            problem.setStatus(status); // APPROVED or NEEDS_FIX
            problemRepository.save(problem);
        });
    }

    public Optional<Problem> getProblem(Long id) {
        return problemRepository.findById(id);
    }

    public List<TestCase> getTestCases(Long problemId) {
        return problemRepository.findById(problemId)
                .map(testCaseRepository::findByProblem)
                .orElse(List.of());
    }

    public TestCase addTestCase(Long problemId, String input, String output, boolean isPublic) {
        return problemRepository.findById(problemId).map(problem -> {
            TestCase testCase = new TestCase();
            testCase.setProblem(problem);
            testCase.setInput(input);
            testCase.setExpectedOutput(output);
            testCase.setPublic(isPublic);
            return testCaseRepository.save(testCase);
        }).orElse(null);
    }

    public List<BugReport> getBugReportsByTester(User tester) {
        return bugReportRepository.findByTester(tester);
    }

    public List<Problem> getAllProblems() {
        return problemRepository.findAll();
    }
}
