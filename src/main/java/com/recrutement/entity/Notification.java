package com.recrutement.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Notifications pour les utilisateurs.
 * Permet de suivre les événements (nouvelle candidature, changement de statut,
 * etc.)
 */
@Entity
@Table(name = "notifications")
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String message;

    @Column(name = "is_read", nullable = false)
    private boolean isRead = false;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "notification_type")
    private String type; // e.g., "NEW_APPLICATION", "STATUS_CHANGE", "INTERVIEW_SCHEDULED"

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public Notification() {
        this.createdAt = LocalDateTime.now();
        this.isRead = false;
    }

    public Notification(String message, String type, User user) {
        this.message = message;
        this.type = type;
        this.user = user;
        this.createdAt = LocalDateTime.now();
        this.isRead = false;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
