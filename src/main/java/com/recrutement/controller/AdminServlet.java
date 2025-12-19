package com.recrutement.controller;

import com.recrutement.dao.*;
import com.recrutement.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet principal d'administration - Dashboard
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");

        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Stats pour le dashboard
        List<User> pendingUsers = userDAO.findByStatus(UserStatus.EN_ATTENTE);
        List<User> enterprises = userDAO.findByRole(Role.ENTERPRISE);
        List<User> candidates = userDAO.findByRole(Role.CANDIDATE);

        request.setAttribute("pendingCount", pendingUsers.size());
        request.setAttribute("enterpriseCount", enterprises.size());
        request.setAttribute("candidateCount", candidates.size());

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}