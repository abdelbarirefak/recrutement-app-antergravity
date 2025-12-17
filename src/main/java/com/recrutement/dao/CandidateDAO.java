package com.recrutement.dao;

import com.recrutement.entity.Candidate;
import com.recrutement.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CandidateDAO {

    public void save(Candidate candidate) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // Vérifier si le candidat existe déjà pour cet utilisateur
            try {
                Candidate existing = em.createQuery("SELECT c FROM Candidate c WHERE c.user.id = :uid", Candidate.class)
                        .setParameter("uid", candidate.getUser().getId())
                        .getSingleResult();

                // Si trouvé, on met à jour l'ID pour que 'merge' fonctionne
                candidate.setId(existing.getId());
                em.merge(candidate);
            } catch (Exception e) {
                // Si pas trouvé, on crée
                em.persist(candidate);
            }

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

    public Candidate findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Candidate.class, id);
        } finally {
            em.close();
        }
    }

    public Candidate findByUserId(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Candidate c WHERE c.user.id = :uid", Candidate.class)
                    .setParameter("uid", userId)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Candidate> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Candidate c", Candidate.class).getResultList();
        } finally {
            em.close();
        }
    }
}