package com.recrutement.dao;

import com.recrutement.entity.InterviewSlot;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class InterviewSlotDAO {

    public void save(InterviewSlot slot) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(slot);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public InterviewSlot findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(InterviewSlot.class, id);
        } finally {
            em.close();
        }
    }

    public List<InterviewSlot> findByEnterpriseId(Long enterpriseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT s FROM InterviewSlot s WHERE s.enterprise.id = :enterpriseId ORDER BY s.date, s.startTime",
                    InterviewSlot.class)
                    .setParameter("enterpriseId", enterpriseId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<InterviewSlot> findAvailableByEnterpriseId(Long enterpriseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT s FROM InterviewSlot s WHERE s.enterprise.id = :enterpriseId AND s.isAvailable = true ORDER BY s.date, s.startTime",
                    InterviewSlot.class)
                    .setParameter("enterpriseId", enterpriseId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void update(InterviewSlot slot) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(slot);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            InterviewSlot slot = em.find(InterviewSlot.class, id);
            if (slot != null) {
                em.remove(slot);
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
}
