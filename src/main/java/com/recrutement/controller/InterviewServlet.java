package com.recrutement.controller;

import com.recrutement.dao.ApplicationDAO;
import com.recrutement.dao.InterviewDAO;
import com.recrutement.dao.InterviewSlotDAO;
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
 * Servlet pour la planification des entretiens par l'admin.
 */
@WebServlet("/admin/interviews")
public class InterviewServlet extends HttpServlet {

    private InterviewDAO interviewDAO = new InterviewDAO();
    private InterviewSlotDAO slotDAO = new InterviewSlotDAO();
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

        // Charger les candidatures acceptées (prêtes pour entretien)
        List<Application> acceptedApps = applicationDAO.findAccepted();
        request.setAttribute("acceptedApplications", acceptedApps);

        // Charger les entretiens existants
        List<Interview> interviews = interviewDAO.findAll();
        request.setAttribute("interviews", interviews);

        request.getRequestDispatcher("/admin-interviews.jsp").forward(request, response);
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

        if ("schedule".equals(action)) {
            // Planifier un entretien
            Long applicationId = Long.parseLong(request.getParameter("applicationId"));
            Long slotId = Long.parseLong(request.getParameter("slotId"));
            String meetLink = request.getParameter("meetLink");

            Application app = applicationDAO.findById(applicationId);
            InterviewSlot slot = slotDAO.findById(slotId);

            if (app != null && slot != null && slot.isAvailable()) {
                // Créer l'entretien
                Interview interview = new Interview(app, slot, meetLink);
                interviewDAO.save(interview);

                // Marquer le créneau comme indisponible
                slot.setAvailable(false);
                slotDAO.update(slot);

                // Notifier le candidat
                notificationService.notify(
                        app.getCandidate().getUser(),
                        "Votre entretien pour \"" + app.getJobOffer().getTitle() + "\" est planifié le " +
                                slot.getDate() + " à " + slot.getStartTime() + ". Lien: " + meetLink,
                        NotificationService.TYPE_INTERVIEW_SCHEDULED);

                // Notifier l'entreprise
                notificationService.notify(
                        app.getJobOffer().getEnterprise().getUser(),
                        "Entretien planifié avec " + app.getCandidate().getFirstName() + " " +
                                app.getCandidate().getLastName() + " le " + slot.getDate() + " à "
                                + slot.getStartTime(),
                        NotificationService.TYPE_INTERVIEW_SCHEDULED);
            }
        } else if ("cancel".equals(action)) {
            Long interviewId = Long.parseLong(request.getParameter("interviewId"));
            interviewDAO.delete(interviewId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/interviews");
    }
}
