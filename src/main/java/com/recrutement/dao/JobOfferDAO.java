package com.recrutement.dao;

import com.recrutement.entity.JobOffer;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class JobOfferDAO {

    public void save(JobOffer offer) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(offer);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public JobOffer findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(JobOffer.class, id);
        } finally {
            em.close();
        }
    }

    public List<JobOffer> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT j FROM JobOffer j ORDER BY j.postedDate DESC", JobOffer.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<JobOffer> findByEnterpriseId(Long enterpriseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery("SELECT j FROM JobOffer j WHERE j.enterprise.id = :entId ORDER BY j.postedDate DESC",
                            JobOffer.class)
                    .setParameter("entId", enterpriseId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void update(JobOffer offer) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(offer);
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
            JobOffer offer = em.find(JobOffer.class, id);
            if (offer != null) {
                em.remove(offer);
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