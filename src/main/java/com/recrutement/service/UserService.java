package com.recrutement.service;

import com.recrutement.dao.CandidateDAO;
import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.dao.UserDAO;
import com.recrutement.entity.Candidate;
import com.recrutement.entity.Enterprise;
import com.recrutement.entity.Role;
import com.recrutement.entity.User;
// import org.mindrot.jbcrypt.BCrypt; // Décommentez si vous utilisez BCrypt plus tard

public class UserService {

    private UserDAO userDAO = new UserDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();

    public void registerUser(User user) {
        // 1. Validation basique
        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new IllegalArgumentException("L'email ne peut pas être vide.");
        }
        if (user.getPassword().length() < 3) { // J'ai réduit à 3 pour faciliter vos tests
            throw new IllegalArgumentException("Le mot de passe est trop court.");
        }

        // 2. Sauvegarde de l'Utilisateur (Login)
        // (Si vous utilisez BCrypt, le hachage se ferait ici)
        userDAO.save(user); 

        // 3. CRÉATION AUTOMATIQUE DU PROFIL
        // Une fois l'user sauvegardé, il a un ID. On peut créer son profil lié.
        
        if (user.getRole() == Role.ENTERPRISE) {
            // Créer un profil Entreprise vide par défaut
            Enterprise enterprise = new Enterprise();
            enterprise.setCompanyName("Nouvelle Entreprise"); // Nom par défaut
            enterprise.setDescription("Description à compléter");
            enterprise.setAddress("Non renseignée");
            enterprise.setUser(user); // LIEN IMPORTANT
            
            enterpriseDAO.save(enterprise);
            
        } else if (user.getRole() == Role.CANDIDATE) {
            // Créer un profil Candidat vide par défaut
            Candidate candidate = new Candidate();
            candidate.setFirstName("Nouveau");
            candidate.setLastName("Candidat");
            candidate.setUser(user); // LIEN IMPORTANT
            
            candidateDAO.save(candidate);
        }
    }

    public User login(String email, String password) {
        User user = userDAO.findByEmail(email);
        // Comparaison simple pour l'instant (remplacez par BCrypt.checkpw si besoin)
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}