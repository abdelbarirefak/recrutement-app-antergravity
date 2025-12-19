package com.recrutement.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Singleton pour gérer l'EntityManagerFactory.
 * Évite la création multiple de factories dans chaque DAO.
 */
public class JPAUtil {

    private static final String PERSISTENCE_UNIT_NAME = "recrutementPU";
    private static EntityManagerFactory emf;

    // Bloc statique pour initialiser l'EMF au chargement de la classe
    static {
        try {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Exception e) {
            System.err.println("ERREUR CRITIQUE JPA : Impossible d'initialiser l'EntityManagerFactory");
            e.printStackTrace(); // Affichera la cause réelle (ex: Connection refused)
            throw new ExceptionInInitializerError(e);
        }
    }

    // Constructeur privé pour empêcher l'instanciation
    private JPAUtil() {
    }

    /**
     * Retourne l'EntityManagerFactory unique.
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

    /**
     * Crée et retourne un nouvel EntityManager.
     */
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    /**
     * Ferme l'EntityManagerFactory (à appeler à l'arrêt de l'application).
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
