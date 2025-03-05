package com.apiconferencia.api_conferencia.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.apiconferencia.api_conferencia.model.User;
import com.apiconferencia.api_conferencia.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // Cambiar la firma para buscar por nombre
    public Optional<User> getUserByName(String name) {
        return userRepository.findByName(name);  // Usar el método findByName
    }

    public User createUser(User user) {
        return userRepository.save(user);
    }

    // Cambiar la firma para eliminar por nombre
    public void deleteUser(String name) {
        Optional<User> user = userRepository.findByName(name);
        user.ifPresent(u -> userRepository.delete(u));  // Eliminar el usuario encontrado
    }
}