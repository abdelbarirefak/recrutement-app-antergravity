package com.recrutement.controller;

import com.recrutement.dao.RegistrationRequestDAO;
import com.recrutement.dao.CandidateDAO;
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
import java.util.stream.Collectors;

/**
 * Servlet pour la gestion des candidats (Admin uniquement).
 */
@WebServlet("/admin/candidats")
public class CandidateManagementServlet extends HttpServlet {

    private RegistrationRequestDAO requestDAO = new RegistrationRequestDAO();
    private UserDAO userDAO = new UserDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();
    private NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Charger les demandes d'inscription CANDIDATE en attente
        List<RegistrationRequest> allPending = requestDAO.findAllPending();
        List<RegistrationRequest> pendingCandidates = allPending.stream()
                .filter(r -> r.getRole() == Role.CANDIDATE)
                .collect(Collectors.toList());
        request.setAttribute("pendingCandidates", pendingCandidates);

        // Charger les candidats actifs
        List<User> allUsers = userDAO.findAll();
        List<User> candidates = allUsers.stream()
                .filter(u -> u.getRole() == Role.CANDIDATE && u.isValidated())
                .collect(Collectors.toList());
        request.setAttribute("candidates", candidates);

        request.getRequestDispatcher("/gestion-candidats.jsp").forward(request, response);
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
        Long id = Long.parseLong(request.getParameter("id"));

        if ("approve".equals(action)) {
            RegistrationRequest regRequest = requestDAO.findById(id);
            if (regRequest != null) {
                // Créer l'utilisateur
                User newUser = new User(regRequest.getEmail(), regRequest.getPassword(), Role.CANDIDATE);
                newUser.setValidated(true);
                userDAO.save(newUser);

                // Créer le profil candidat
                Candidate candidate = new Candidate();
                candidate.setFirstName(regRequest.getFirstName() != null ? regRequest.getFirstName() : "Nouveau");
                candidate.setLastName(regRequest.getLastName() != null ? regRequest.getLastName() : "Candidat");
                candidate.setUser(newUser);
                candidateDAO.save(candidate);

                // Mettre à jour le statut de la demande
                regRequest.setStatus(RequestStatus.APPROVED);
                requestDAO.update(regRequest);

                // Notifier
                notificationService.notify(newUser, "Votre inscription a été approuvée !",
                        NotificationService.TYPE_REGISTRATION_APPROVED);
            }
        } else if ("reject".equals(action)) {
            RegistrationRequest regRequest = requestDAO.findById(id);
            if (regRequest != null) {
                regRequest.setStatus(RequestStatus.REJECTED);
                requestDAO.update(regRequest);
            }
        } else if ("delete".equals(action)) {
            userDAO.delete(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/candidats");
    }
}
