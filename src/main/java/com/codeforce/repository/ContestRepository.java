package com.codeforce.repository;

import com.codeforce.model.Contest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ContestRepository extends JpaRepository<Contest, Long> {
    List<Contest> findByPhaseOrderByStartTimeDesc(String phase);
    List<Contest> findAllByOrderByStartTimeDesc();
    List<Contest> findByPhase(String phase);
    List<Contest> findByNameContainingIgnoreCase(String name);
}
