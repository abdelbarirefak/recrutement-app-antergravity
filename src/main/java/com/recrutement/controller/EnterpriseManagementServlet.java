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
import java.util.stream.Collectors;

/**
 * Servlet pour la gestion des entreprises (Admin uniquement).
 */
@WebServlet("/admin/entreprises")
public class EnterpriseManagementServlet extends HttpServlet {

    private RegistrationRequestDAO requestDAO = new RegistrationRequestDAO();
    private UserDAO userDAO = new UserDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();
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

        // Charger les demandes d'inscription ENTREPRISE en attente
        List<RegistrationRequest> allPending = requestDAO.findAllPending();
        List<RegistrationRequest> pendingEnterprises = allPending.stream()
                .filter(r -> r.getRole() == Role.ENTERPRISE)
                .collect(Collectors.toList());
        request.setAttribute("pendingEnterprises", pendingEnterprises);

        // Charger les entreprises actives
        List<User> allUsers = userDAO.findAll();
        List<User> enterprises = allUsers.stream()
                .filter(u -> u.getRole() == Role.ENTERPRISE && u.isValidated())
                .collect(Collectors.toList());
        request.setAttribute("enterprises", enterprises);

        request.getRequestDispatcher("/gestion-entreprises.jsp").forward(request, response);
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
                User newUser = new User(regRequest.getEmail(), regRequest.getPassword(), Role.ENTERPRISE);
                newUser.setValidated(true);
                userDAO.save(newUser);

                // Créer le profil entreprise
                Enterprise enterprise = new Enterprise();
                enterprise.setCompanyName(
                        regRequest.getCompanyName() != null ? regRequest.getCompanyName() : "Entreprise");
                enterprise.setUser(newUser);
                enterpriseDAO.save(enterprise);

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

        response.sendRedirect(request.getContextPath() + "/admin/entreprises");
    }
}
