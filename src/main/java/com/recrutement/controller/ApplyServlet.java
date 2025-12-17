package com.recrutement.controller;

import com.recrutement.dao.ApplicationDAO;
import com.recrutement.dao.CandidateDAO;
import com.recrutement.dao.JobOfferDAO;
import com.recrutement.entity.*;
import com.recrutement.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet pour postuler à une offre d'emploi.
 * Accessible uniquement aux candidats connectés.
 */
@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {

    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();
    private NotificationService notificationService = new NotificationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        // Vérification : utilisateur connecté et candidat
        if (loggedUser == null || loggedUser.getRole() != Role.CANDIDATE) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer les paramètres
        Long jobOfferId = Long.parseLong(request.getParameter("jobId"));
        String coverLetter = request.getParameter("coverLetter");

        // Récupérer le profil candidat
        Candidate candidate = candidateDAO.findByUserId(loggedUser.getId());
        if (candidate == null) {
            request.setAttribute("error", "Veuillez d'abord compléter votre profil candidat.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        // Récupérer l'offre
        JobOffer jobOffer = jobOfferDAO.findById(jobOfferId);
        if (jobOffer == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        // Créer la candidature
        Application application = new Application(candidate, jobOffer);
        application.setCoverLetter(coverLetter);
        // adminValidated = false par défaut (anonymat)

        applicationDAO.save(application);

        // Notifier l'admin (pas l'entreprise car c'est anonyme)
        // L'admin sera notifié via le dashboard

        response.sendRedirect(request.getContextPath() + "/dashboard.jsp?applied=success");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher le formulaire de candidature avec l'offre
        String jobIdParam = request.getParameter("jobId");
        if (jobIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        Long jobId = Long.parseLong(jobIdParam);
        JobOffer jobOffer = jobOfferDAO.findById(jobId);
        request.setAttribute("jobOffer", jobOffer);

        request.getRequestDispatcher("/apply.jsp").forward(request, response);
    }
}
