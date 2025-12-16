package com.recrutement.dao;

import com.recrutement.entity.JobOffer;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class JobOfferDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public void save(JobOffer jobOffer) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(jobOffer);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public JobOffer findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(JobOffer.class, id);
        } finally {
            em.close();
        }
    }

    // Get all jobs (for the job board page)
    public List<JobOffer> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT j FROM JobOffer j", JobOffer.class).getResultList();
        } finally {
            em.close();
        }
    }
}