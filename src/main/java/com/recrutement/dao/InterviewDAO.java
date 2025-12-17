package com.recrutement.dao;

import com.recrutement.entity.Interview;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class InterviewDAO {

    public void save(Interview interview) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(interview);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Interview findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Interview.class, id);
        } finally {
            em.close();
        }
    }

    public Interview findByApplicationId(Long applicationId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT i FROM Interview i WHERE i.application.id = :appId", Interview.class)
                    .setParameter("appId", applicationId)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Interview> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT i FROM Interview i ORDER BY i.slot.date, i.slot.startTime", Interview.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Interview interview = em.find(Interview.class, id);
            if (interview != null) {
                // Rendre le créneau disponible à nouveau
                interview.getSlot().setAvailable(true);
                em.merge(interview.getSlot());
                em.remove(interview);
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
