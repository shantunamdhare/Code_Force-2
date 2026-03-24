package com.codeforce.service;

import com.codeforce.model.Submission;
import com.codeforce.model.User;
import com.codeforce.model.Problem;
import com.codeforce.repository.SubmissionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubmissionService {

    private final SubmissionRepository submissionRepository;

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
        return submissionRepository.findTop20ByOrderBySubmittedAtDesc();
    }

    public long countByUser(User user) {
        return submissionRepository.countByUser(user);
    }

    public long countAcceptedByUser(User user) {
        return submissionRepository.countByUserAndVerdict(user, "Accepted");
    }
}
