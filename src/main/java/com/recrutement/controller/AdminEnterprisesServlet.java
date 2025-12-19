package com.recrutement.controller;

import com.recrutement.dao.UserDAO;
import com.recrutement.dao.EnterpriseDAO;
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
 * Servlet pour la gestion des entreprises
 */
@WebServlet("/admin/entreprises")
public class AdminEnterprisesServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<User> enterprises = userDAO.findByRole(Role.ENTERPRISE);
        request.setAttribute("enterprises", enterprises);

        request.getRequestDispatcher("/admin-entreprises.jsp").forward(request, response);
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

        if ("delete".equals(action)) {
            userDAO.delete(userId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/entreprises");
    }
}
