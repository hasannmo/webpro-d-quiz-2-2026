package com.mijusan.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String email;
    private String username;
    private String password;
    private String role; // "Customer", "Administrator", "Creator"
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public User() {}

    public User(int id, String name, String email, String username, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.username = username;
        this.role = role;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role == null ? "Customer" : role; }
    public void setRole(String role) { this.role = role; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public boolean isAdmin() {
        return "Administrator".equalsIgnoreCase(role) || "Creator".equalsIgnoreCase(role);
    }

    public boolean isCreator() {
        return "Creator".equalsIgnoreCase(role);
    }
}
