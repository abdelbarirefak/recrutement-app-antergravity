package com.recrutement.entity;

/**
 * Statut de validation d'un compte utilisateur.
 * EN_ATTENTE : Compte créé mais non validé par l'admin
 * VALIDE : Compte validé, l'utilisateur peut se connecter
 */
public enum UserStatus {
    EN_ATTENTE,
    VALIDE
}
