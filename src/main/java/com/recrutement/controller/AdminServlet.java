package com.recrutement.controller;

import com.recrutement.dao.ApplicationDAO;
import com.recrutement.dao.JobOfferDAO;
import com.recrutement.dao.RegistrationRequestDAO;
import com.recrutement.dao.UserDAO;
import com.recrutement.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private RegistrationRequestDAO requestDAO = new RegistrationRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null || user.getRole() != Role.ADMIN) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Charger les données pour le nouveau dashboard
        List<RegistrationRequest> pendingRequests = requestDAO.findAllPending();
        List<Application> pendingApplications = applicationDAO.findPendingValidation();

        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("pendingApplications", pendingApplications);

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("validate_user".equals(action)) {
                long userId = Long.parseLong(request.getParameter("id"));
                User u = userDAO.findById(userId);
                if (u != null) {
                    u.setValidated(true);
                    userDAO.update(u);
                }
            } else if ("delete_user".equals(action)) {
                long userId = Long.parseLong(request.getParameter("id"));
                userDAO.delete(userId);
            } else if ("delete_offer".equals(action)) {
                long offerId = Long.parseLong(request.getParameter("id"));
                jobOfferDAO.delete(offerId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin");
    }
}