package com.apiconferencia.api_conferencia.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.apiconferencia.api_conferencia.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    // Método para buscar un usuario por nombre
    Optional<User> findByName(String name);
}