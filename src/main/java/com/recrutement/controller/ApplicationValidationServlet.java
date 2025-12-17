package com.recrutement.controller;

import com.recrutement.dao.ApplicationDAO;
import com.recrutement.entity.Application;
import com.recrutement.entity.Role;
import com.recrutement.entity.User;
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
 * Servlet pour la gestion des candidatures par l'admin.
 * Gère l'anonymat et la validation des candidatures.
 */
@WebServlet("/admin/applications")
public class ApplicationValidationServlet extends HttpServlet {

    private ApplicationDAO applicationDAO = new ApplicationDAO();
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

        // Charger les candidatures en attente de validation (anonymes)
        List<Application> pendingValidation = applicationDAO.findPendingValidation();
        request.setAttribute("pendingApplications", pendingValidation);

        // Charger toutes les candidatures
        List<Application> allApplications = applicationDAO.findAll();
        request.setAttribute("allApplications", allApplications);

        request.getRequestDispatcher("/admin-applications.jsp").forward(request, response);
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
        Long applicationId = Long.parseLong(request.getParameter("id"));
        Application app = applicationDAO.findById(applicationId);

        if (app == null) {
            response.sendRedirect(request.getContextPath() + "/admin/applications");
            return;
        }

        if ("reveal_identity".equals(action)) {
            // Valider la candidature - révéler l'identité à l'entreprise
            app.setAdminValidated(true);
            applicationDAO.update(app);

            // Notifier le candidat
            notificationService.notify(
                    app.getCandidate().getUser(),
                    "Votre candidature pour \"" + app.getJobOffer().getTitle()
                            + "\" a été validée par l'administration.",
                    NotificationService.TYPE_IDENTITY_REVEALED);

            // Notifier l'entreprise
            notificationService.notify(
                    app.getJobOffer().getEnterprise().getUser(),
                    "Une nouvelle candidature validée pour \"" + app.getJobOffer().getTitle()
                            + "\" - Profil disponible.",
                    NotificationService.TYPE_NEW_APPLICATION);
        }

        response.sendRedirect(request.getContextPath() + "/admin/applications");
    }
}
