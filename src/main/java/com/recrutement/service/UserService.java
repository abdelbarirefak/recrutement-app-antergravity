package com.recrutement.service;

import com.recrutement.dao.CandidateDAO;
import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.dao.UserDAO;
import com.recrutement.entity.Candidate;
import com.recrutement.entity.Enterprise;
import com.recrutement.entity.Role;
import com.recrutement.entity.User;

public class UserService {

    private UserDAO userDAO = new UserDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();

    public void registerUser(User user) {
        // 1. Validation basique
        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new IllegalArgumentException("L'email ne peut pas être vide.");
        }
        if (user.getPassword().length() < 3) {
            throw new IllegalArgumentException("Le mot de passe est trop court.");
        }

        // 2. Sauvegarde de l'Utilisateur
        // UserDAO.save() utilise persist(), donc 'user' sera mis à jour avec son ID
        // généré.
        userDAO.save(user);

        // 3. CRÉATION AUTOMATIQUE DU PROFIL
        if (user.getRole() == Role.ENTERPRISE) {
            Enterprise enterprise = new Enterprise();
            enterprise.setCompanyName("Mon Entreprise (à configurer)");
            enterprise.setDescription("Description par défaut");
            enterprise.setAddress("Adresse à compléter");
            enterprise.setUser(user); // Important : user a maintenant un ID grâce à l'étape 2

            enterpriseDAO.save(enterprise);

        } else if (user.getRole() == Role.CANDIDATE) {
            Candidate candidate = new Candidate();
            candidate.setFirstName("Nouveau");
            candidate.setLastName("Candidat");
            candidate.setTitle("En recherche active");
            candidate.setUser(user); // Important : user a maintenant un ID

            candidateDAO.save(candidate);
        }
    }

    public User login(String email, String password) {
        User user = userDAO.findByEmail(email);

        // MODIFICATION: Compare passwords directly as plain text
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}