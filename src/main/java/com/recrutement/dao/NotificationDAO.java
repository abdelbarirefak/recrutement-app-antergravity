package com.recrutement.dao;

import com.recrutement.entity.Notification;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class NotificationDAO {

    public void save(Notification notification) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(notification);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Notification> findByUserId(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery("SELECT n FROM Notification n WHERE n.user.id = :userId ORDER BY n.createdAt DESC",
                            Notification.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Notification> findUnreadByUserId(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT n FROM Notification n WHERE n.user.id = :userId AND n.isRead = false ORDER BY n.createdAt DESC",
                    Notification.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Long countUnreadByUserId(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery("SELECT COUNT(n) FROM Notification n WHERE n.user.id = :userId AND n.isRead = false",
                            Long.class)
                    .setParameter("userId", userId)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public void markAsRead(Long notificationId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Notification n = em.find(Notification.class, notificationId);
            if (n != null) {
                n.setRead(true);
                em.merge(n);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void markAllAsRead(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("UPDATE Notification n SET n.isRead = true WHERE n.user.id = :userId")
                    .setParameter("userId", userId)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
