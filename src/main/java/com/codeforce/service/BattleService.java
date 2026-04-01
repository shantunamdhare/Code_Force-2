package com.codeforce.service;

import com.codeforce.model.Problem;
import com.codeforce.model.User;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class BattleService {
    
    public static class BattleSession {
        private User challenger;
        private User opponent;
        private Problem problem;
        private boolean active;

        public BattleSession(User challenger, User opponent, Problem problem) {
            this.challenger = challenger;
            this.opponent = opponent;
            this.problem = problem;
            this.active = true;
        }

        public User getChallenger() { return challenger; }
        public User getOpponent() { return opponent; }
        public Problem getProblem() { return problem; }
        public boolean isActive() { return active; }
        public void setActive(boolean active) { this.active = active; }
    }

    private final Map<Long, BattleSession> sessions = new ConcurrentHashMap<>();

    public BattleSession initiateBattle(User challenger, User opponent, Problem problem) {
        BattleSession session = new BattleSession(challenger, opponent, problem);
        sessions.put(challenger.getId(), session);
        sessions.put(opponent.getId(), session);
        return session;
    }

    public Optional<BattleSession> getActiveSession(Long userId) {
        return Optional.ofNullable(sessions.get(userId));
    }

    public void endSession(Long userId) {
        BattleSession session = sessions.remove(userId);
        if (session != null) {
            sessions.remove(session.getChallenger().getId());
            sessions.remove(session.getOpponent().getId());
        }
    }
}
