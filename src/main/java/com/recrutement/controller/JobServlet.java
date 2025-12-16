package com.recrutement.controller;

import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.dao.JobOfferDAO;
import com.recrutement.entity.Enterprise;
import com.recrutement.entity.JobOffer;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/post-job")
public class JobServlet extends HttpServlet {

    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Récupérer l'utilisateur connecté (Sécurité)
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null || !"ENTERPRISE".equals(loggedUser.getRole().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Récupérer les données du formulaire
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        Double salary = Double.parseDouble(request.getParameter("salary"));

        // 3. Retrouver le profil "Enterprise" lié à cet Utilisateur
        // (Attention : loggedUser est juste le login, il faut trouver l'Entité Enterprise correspondante)
        // Pour faire simple ici, nous supposons que nous pouvons la trouver via l'ID utilisateur.
        // *Note : Vous devrez peut-être ajouter une méthode `findByUserId` dans EnterpriseDAO si elle n'existe pas.*
        // Pour l'instant, utilisons une astuce ou ajoutons la méthode.
        
        // Supposons que nous ayons ajouté cette méthode dans EnterpriseDAO (voir étape 3 ci-dessous)
        Enterprise enterprise = enterpriseDAO.findByUserId(loggedUser.getId());

        if (enterprise != null) {
            // 4. Créer et sauvegarder l'offre
            JobOffer newJob = new JobOffer(title, description, location, salary, enterprise);
            jobOfferDAO.save(newJob);

            // 5. Succès ! Retour au tableau de bord
            response.sendRedirect("dashboard.jsp?success=JobPosted");
        } else {
            response.getWriter().write("Erreur : Profil Entreprise introuvable. Avez-vous complété votre profil ?");
        }
    }
}