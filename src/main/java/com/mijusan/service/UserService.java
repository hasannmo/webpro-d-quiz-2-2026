package com.mijusan.service;

import com.mijusan.dao.UserDAO;
import com.mijusan.model.User;
import com.mijusan.util.SlugUtil;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User authenticate(String emailOrUsername, String rawPassword) {
        if (emailOrUsername == null || rawPassword == null) return null;
        String query = emailOrUsername.trim();
        User user = userDAO.findByEmail(query);
        if (user == null) {
            user = userDAO.findByUsername(query);
        }
        if (user != null && user.getPassword() != null) {
            String hash = user.getPassword();
            // Handle Laravel standard $2y$ prefix by converting to $2a$ for jBCrypt if needed
            if (hash.startsWith("$2y$")) {
                hash = "$2a$" + hash.substring(4);
            }
            try {
                if (BCrypt.checkpw(rawPassword, hash)) {
                    return user;
                }
            } catch (Exception e) {
                // If stored in plain text or legacy
                if (user.getPassword().equals(rawPassword)) {
                    return user;
                }
            }
        }
        return null;
    }

    public boolean register(String name, String email, String username, String rawPassword) {
        if (email == null || rawPassword == null || name == null) return false;
        if (userDAO.findByEmail(email.trim()) != null) return false;

        if (username == null || username.trim().isEmpty()) {
            username = SlugUtil.toSlug(name);
        }
        if (userDAO.findByUsername(username.trim()) != null) {
            username = username + System.currentTimeMillis() % 1000;
        }

        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));
        User u = new User();
        u.setName(name.trim());
        u.setEmail(email.trim().toLowerCase());
        u.setUsername(username.trim());
        u.setPassword(hashedPassword);
        u.setRole("Customer");
        return userDAO.create(u);
    }

    public boolean createUser(String name, String email, String username, String rawPassword, String role) {
        if (email == null || rawPassword == null || name == null) return false;
        if (userDAO.findByEmail(email.trim()) != null) return false;

        if (username == null || username.trim().isEmpty()) {
            username = SlugUtil.toSlug(name);
        }
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));
        User u = new User();
        u.setName(name.trim());
        u.setEmail(email.trim().toLowerCase());
        u.setUsername(username.trim());
        u.setPassword(hashedPassword);
        u.setRole(role != null ? role : "Customer");
        return userDAO.create(u);
    }

    public List<User> paginate(int page, int pageSize) {
        return userDAO.paginate(page, pageSize);
    }

    public int getTotalCount() {
        return userDAO.count();
    }

    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    public boolean updateUserRole(int id, String role) {
        return userDAO.updateRole(id, role);
    }

    public boolean updateProfile(int id, String name, String username, String email) {
        User u = userDAO.findById(id);
        if (u == null) return false;
        u.setName(name);
        u.setUsername(username);
        u.setEmail(email);
        return userDAO.update(u);
    }

    public boolean updatePassword(int id, String newPassword) {
        String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
        return userDAO.updatePassword(id, hashed);
    }

    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }
}
