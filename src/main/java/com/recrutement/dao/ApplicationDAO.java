package com.recrutement.dao;

import com.recrutement.entity.Application;
import com.recrutement.entity.ApplicationStatus;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ApplicationDAO {

    public void save(Application application) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(application);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Application findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Application.class, id);
        } finally {
            em.close();
        }
    }

    public List<Application> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Application a ORDER BY a.applicationDate DESC", Application.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Application> findByJobOfferId(Long jobOfferId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery(
                            "SELECT a FROM Application a WHERE a.jobOffer.id = :jobId ORDER BY a.applicationDate DESC",
                            Application.class)
                    .setParameter("jobId", jobOfferId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Application> findByCandidateId(Long candidateId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT a FROM Application a WHERE a.candidate.id = :candId ORDER BY a.applicationDate DESC",
                    Application.class)
                    .setParameter("candId", candidateId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Application> findPendingValidation() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT a FROM Application a WHERE a.adminValidated = false ORDER BY a.applicationDate DESC",
                    Application.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Application> findAccepted() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT a FROM Application a WHERE a.status = :status AND a.adminValidated = true ORDER BY a.applicationDate DESC",
                    Application.class)
                    .setParameter("status", ApplicationStatus.ACCEPTED)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Application application) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(application);
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
            Application app = em.find(Application.class, id);
            if (app != null) {
                em.remove(app);
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