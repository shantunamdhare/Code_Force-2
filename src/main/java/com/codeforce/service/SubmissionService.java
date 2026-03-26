package com.codeforce.service;

import com.codeforce.model.Submission;
import com.codeforce.model.User;
import com.codeforce.model.Problem;
import com.codeforce.repository.SubmissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SubmissionService {

    private final SubmissionRepository submissionRepository;

    @Autowired
    public SubmissionService(SubmissionRepository submissionRepository) {
        this.submissionRepository = submissionRepository;
    }

    public Submission submit(Submission submission) {
        return submissionRepository.save(submission);
    }

    public Optional<Submission> findById(Long id) {
        return submissionRepository.findById(id);
    }

    public List<Submission> getUserSubmissions(User user) {
        return submissionRepository.findByUserOrderBySubmittedAtDesc(user);
    }

    public List<Submission> getProblemSubmissions(Problem problem) {
        return submissionRepository.findByProblemOrderBySubmittedAtDesc(problem);
    }

    public List<Submission> getRecentSubmissions() {
        return submissionRepository.findTop10ByOrderBySubmittedAtDesc();
    }

    public long countByUser(User user) {
        return submissionRepository.countByUser(user);
    }

    public long countAcceptedByUser(User user) {
        return submissionRepository.countByUserAndVerdict(user, "Accepted");
    }

    public List<Submission> getSecondChanceSubmissions(User user, com.codeforce.model.Contest contest) {
        return submissionRepository.findByUserAndContestAndIsSecondChanceOrderBySubmittedAtDesc(user, contest, true);
    }

    public List<Submission> getOfficialContestSubmissions(User user, com.codeforce.model.Contest contest) {
        return submissionRepository.findByUserAndContestAndIsSecondChanceOrderBySubmittedAtDesc(user, contest, false);
    }

    public long countSecondChanceAcceptedByUser(User user) {
        return submissionRepository.countByUserAndIsSecondChanceAndVerdict(user, true, "Accepted");
    }
}
