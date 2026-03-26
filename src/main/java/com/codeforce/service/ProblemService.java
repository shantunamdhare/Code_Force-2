package com.codeforce.service;

import com.codeforce.model.Problem;
import com.codeforce.repository.ProblemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProblemService {

    private final ProblemRepository problemRepository;

    @Autowired
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

    public List<Problem> getProblemsByTopicAndDifficulty(String topic, String difficulty) {
        return switch (difficulty.toLowerCase()) {
            case "easy" -> problemRepository.findByTags_NameIgnoreCaseAndDifficultyRatingBetween(topic, 0, 1200);
            case "medium" -> problemRepository.findByTags_NameIgnoreCaseAndDifficultyRatingBetween(topic, 1201, 1800);
            case "hard" -> problemRepository.findByTags_NameIgnoreCaseAndDifficultyRatingBetween(topic, 1801, 3500);
            default -> problemRepository.findByTags_NameIgnoreCase(topic);
        };
    }

    public List<Problem> getRecommendedProblems(com.codeforce.model.User user) {
        // Simple recommendation: pick problems from topics the user hasn't solved yet
        // For now, return a few random problems of moderate difficulty
        return problemRepository.findByDifficultyRatingBetween(1000, 1600).stream()
                .limit(3)
                .toList();
    }

    public Problem save(Problem problem) {
        return problemRepository.save(problem);
    }

    public long count() {
        return problemRepository.count();
    }
}
