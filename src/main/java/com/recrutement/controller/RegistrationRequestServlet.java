package com.recrutement.controller;

import com.recrutement.dao.RegistrationRequestDAO;
import com.recrutement.dao.CandidateDAO;
import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.dao.UserDAO;
import com.recrutement.entity.*;
import com.recrutement.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet pour gérer les demandes d'inscription (Admin uniquement).
 */
@WebServlet("/admin/registrations")
public class RegistrationRequestServlet extends HttpServlet {

    private RegistrationRequestDAO requestDAO = new RegistrationRequestDAO();
    private UserDAO userDAO = new UserDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
    private NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Vérification admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Charger les demandes en attente
        List<RegistrationRequest> pendingRequests = requestDAO.findAllPending();
        request.setAttribute("pendingRequests", pendingRequests);

        request.getRequestDispatcher("/admin-registrations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        Long requestId = Long.parseLong(request.getParameter("id"));

        RegistrationRequest regRequest = requestDAO.findById(requestId);
        if (regRequest == null) {
            response.sendRedirect(request.getContextPath() + "/admin/registrations");
            return;
        }

        if ("approve".equals(action)) {
            // Créer l'utilisateur
            User newUser = new User(regRequest.getEmail(), regRequest.getPassword(), regRequest.getRole());
            newUser.setValidated(true);
            userDAO.save(newUser);

            // Créer le profil selon le rôle
            if (regRequest.getRole() == Role.CANDIDATE) {
                Candidate candidate = new Candidate();
                candidate.setFirstName(regRequest.getFirstName() != null ? regRequest.getFirstName() : "Nouveau");
                candidate.setLastName(regRequest.getLastName() != null ? regRequest.getLastName() : "Candidat");
                candidate.setUser(newUser);
                candidateDAO.save(candidate);
            } else if (regRequest.getRole() == Role.ENTERPRISE) {
                Enterprise enterprise = new Enterprise();
                enterprise.setCompanyName(
                        regRequest.getCompanyName() != null ? regRequest.getCompanyName() : "Nouvelle Entreprise");
                enterprise.setUser(newUser);
                enterpriseDAO.save(enterprise);
            }

            // Mettre à jour le statut de la demande
            regRequest.setStatus(RequestStatus.APPROVED);
            requestDAO.update(regRequest);

            // Notifier l'utilisateur (bien que non connecté, la notif sera visible à la
            // connexion)
            notificationService.notify(newUser, "Votre inscription a été approuvée ! Bienvenue sur JobBoard.",
                    NotificationService.TYPE_REGISTRATION_APPROVED);

        } else if ("reject".equals(action)) {
            regRequest.setStatus(RequestStatus.REJECTED);
            requestDAO.update(regRequest);
        }

        response.sendRedirect(request.getContextPath() + "/admin/registrations");
    }
}
