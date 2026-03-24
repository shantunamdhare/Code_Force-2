package com.codeforce.service;

import com.codeforce.model.User;
import com.codeforce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User register(User user) {
        user.setRank(user.getRankTitle());
        user.setMaxRank(user.getRankTitle());
        return userRepository.save(user);
    }

    public Optional<User> login(String handleOrEmail, String password) {
        return userRepository.findByLoginAndPassword(handleOrEmail, password);
    }

    public Optional<User> findByHandle(String handle) {
        return userRepository.findByHandle(handle);
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> getTopRated() {
        return userRepository.findTop10ByOrderByRatingDesc();
    }

    public List<User> getAllByRating() {
        return userRepository.findAllByOrderByRatingDesc();
    }

    public List<User> searchUsers(String query) {
        return userRepository.findByHandleContainingIgnoreCase(query);
    }

    public boolean handleExists(String handle) {
        return userRepository.existsByHandle(handle);
    }

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public long count() {
        return userRepository.count();
    }
}
