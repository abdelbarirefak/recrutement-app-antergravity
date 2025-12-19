package com.recrutement.controller;

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

/**
 * Servlet pour la gestion des validations de comptes
 */
@WebServlet("/admin/validations")
public class AdminValidationServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer tous les utilisateurs EN_ATTENTE (sauf admin)
        List<User> pendingUsers = userDAO.findByStatus(UserStatus.EN_ATTENTE);
        request.setAttribute("pendingUsers", pendingUsers);

        request.getRequestDispatcher("/admin-validations.jsp").forward(request, response);
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
        Long userId = Long.parseLong(request.getParameter("userId"));

        if ("accept".equals(action)) {
            userDAO.updateStatus(userId, UserStatus.VALIDE);
        } else if ("refuse".equals(action)) {
            userDAO.delete(userId);
        }

        String isAjax = request.getParameter("ajax");
        if ("true".equals(isAjax)) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/validations");
        }
    }
}
