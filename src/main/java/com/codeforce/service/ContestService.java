package com.codeforce.service;

import com.codeforce.model.Contest;
import com.codeforce.repository.ContestRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ContestService {

    private final ContestRepository contestRepository;

    public ContestService(ContestRepository contestRepository) {
        this.contestRepository = contestRepository;
    }

    public List<Contest> getAllContests() {
        return contestRepository.findAllByOrderByStartTimeDesc();
    }

    public Optional<Contest> findById(Long id) {
        return contestRepository.findById(id);
    }

    public List<Contest> getUpcomingContests() {
        return contestRepository.findByPhase("BEFORE");
    }

    public List<Contest> getRunningContests() {
        return contestRepository.findByPhase("CODING");
    }

    public List<Contest> getFinishedContests() {
        return contestRepository.findByPhaseOrderByStartTimeDesc("FINISHED");
    }

    public Contest save(Contest contest) {
        return contestRepository.save(contest);
    }

    public long count() {
        return contestRepository.count();
    }
}
