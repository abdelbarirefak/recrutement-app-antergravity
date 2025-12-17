package com.recrutement.dao;

import com.recrutement.entity.RegistrationRequest;
import com.recrutement.entity.RequestStatus;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class RegistrationRequestDAO {

    public void save(RegistrationRequest request) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(request);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public RegistrationRequest findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(RegistrationRequest.class, id);
        } finally {
            em.close();
        }
    }

    public List<RegistrationRequest> findByStatus(RequestStatus status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery(
                            "SELECT r FROM RegistrationRequest r WHERE r.status = :status ORDER BY r.createdAt DESC",
                            RegistrationRequest.class)
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<RegistrationRequest> findAllPending() {
        return findByStatus(RequestStatus.PENDING);
    }

    public void update(RegistrationRequest request) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(request);
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
            RegistrationRequest request = em.find(RegistrationRequest.class, id);
            if (request != null) {
                em.remove(request);
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
