package com.recrutement.service;

import com.recrutement.dao.NotificationDAO;
import com.recrutement.entity.Notification;
import com.recrutement.entity.User;
import java.util.List;

/**
 * Service pour gérer les notifications utilisateur.
 */
public class NotificationService {

    private NotificationDAO notificationDAO = new NotificationDAO();

    /**
     * Crée une nouvelle notification pour un utilisateur.
     */
    public void notify(User user, String message, String type) {
        Notification notification = new Notification(message, type, user);
        notificationDAO.save(notification);
    }

    /**
     * Récupère toutes les notifications d'un utilisateur.
     */
    public List<Notification> getNotifications(Long userId) {
        return notificationDAO.findByUserId(userId);
    }

    /**
     * Récupère les notifications non lues.
     */
    public List<Notification> getUnreadNotifications(Long userId) {
        return notificationDAO.findUnreadByUserId(userId);
    }

    /**
     * Compte les notifications non lues.
     */
    public Long countUnread(Long userId) {
        return notificationDAO.countUnreadByUserId(userId);
    }

    /**
     * Marque une notification comme lue.
     */
    public void markAsRead(Long notificationId) {
        notificationDAO.markAsRead(notificationId);
    }

    /**
     * Marque toutes les notifications d'un utilisateur comme lues.
     */
    public void markAllAsRead(Long userId) {
        notificationDAO.markAllAsRead(userId);
    }

    // Types de notification prédéfinis
    public static final String TYPE_NEW_APPLICATION = "NEW_APPLICATION";
    public static final String TYPE_STATUS_CHANGE = "STATUS_CHANGE";
    public static final String TYPE_INTERVIEW_SCHEDULED = "INTERVIEW_SCHEDULED";
    public static final String TYPE_REGISTRATION_APPROVED = "REGISTRATION_APPROVED";
    public static final String TYPE_IDENTITY_REVEALED = "IDENTITY_REVEALED";
}
