package com.recrutement.dao;

import com.recrutement.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class UserDAO {

    // We create one factory for the whole app (in a real app, this would be a Singleton)
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("recrutementPU");

    public void save(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
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

    public User findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            // Using JPQL (Java Persistence Query Language) to find a user by email
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (Exception e) {
            return null; // Return null if user not found
        } finally {
            em.close();
        }
    }
}