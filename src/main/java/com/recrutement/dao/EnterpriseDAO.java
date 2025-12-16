package com.recrutement.dao;

import com.recrutement.entity.Enterprise;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EnterpriseDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public void save(Enterprise enterprise) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(enterprise);
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

    public Enterprise findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Enterprise.class, id);
        } finally {
            em.close();
        }
    }
    
    public Enterprise findByUserId(Long userId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT e FROM Enterprise e WHERE e.user.id = :userId", Enterprise.class)
                     .setParameter("userId", userId)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
}