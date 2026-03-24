package com.codeforce.service;

import com.codeforce.model.Problem;
import com.codeforce.repository.ProblemRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProblemService {

    private final ProblemRepository problemRepository;

    public ProblemService(ProblemRepository problemRepository) {
        this.problemRepository = problemRepository;
    }

    public List<Problem> getAllProblems() {
        return problemRepository.findAllByOrderByDifficultyRatingAsc();
    }

    public Optional<Problem> findById(Long id) {
        return problemRepository.findById(id);
    }

    public List<Problem> findByContest(String contestId) {
        return problemRepository.findByContestId(contestId);
    }

    public List<Problem> findByDifficultyRange(Integer min, Integer max) {
        return problemRepository.findByDifficultyRatingBetween(min, max);
    }

    public List<Problem> searchProblems(String query) {
        return problemRepository.findByNameContainingIgnoreCase(query);
    }

    public List<Problem> findByTag(String tagName) {
        return problemRepository.findByTags_NameIgnoreCase(tagName);
    }

    public Problem save(Problem problem) {
        return problemRepository.save(problem);
    }

    public long count() {
        return problemRepository.count();
    }
}
