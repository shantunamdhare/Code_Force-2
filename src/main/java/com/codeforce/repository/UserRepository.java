package com.codeforce.repository;

import com.codeforce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByHandle(String handle);
    Optional<User> findByEmail(String email);

    @org.springframework.data.jpa.repository.Query("SELECT u FROM User u WHERE (LOWER(u.handle) = LOWER(:login) OR LOWER(u.email) = LOWER(:login))")
    Optional<User> findByHandleOrEmailIgnoreCase(@org.springframework.data.repository.query.Param("login") String login);
    
    List<User> findTop10ByOrderByRatingDesc();
    List<User> findAllByOrderByRatingDesc();
    List<User> findByCountryOrderByRatingDesc(String country);
    List<User> findByHandleContainingIgnoreCase(String handle);
    boolean existsByHandleIgnoreCase(String handle);
    boolean existsByEmailIgnoreCase(String email);
    long countByRatingGreaterThan(Integer rating);
}
