package com.recrutement.entity;

/**
 * Statut des demandes d'inscription.
 */
public enum RequestStatus {
    PENDING, // En attente de validation admin
    APPROVED, // Approuvé par l'admin
    REJECTED // Refusé par l'admin
}
