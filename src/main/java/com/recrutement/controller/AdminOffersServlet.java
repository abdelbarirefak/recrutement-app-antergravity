package com.recrutement.controller;

import com.recrutement.dao.JobOfferDAO;
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
 * Servlet pour la modération des offres d'emploi
 */
@WebServlet("/admin/offres")
public class AdminOffersServlet extends HttpServlet {

    private JobOfferDAO jobOfferDAO = new JobOfferDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("loggedUser");
        if (admin == null || admin.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<JobOffer> offers = jobOfferDAO.findAll();
        request.setAttribute("offers", offers);

        request.getRequestDispatcher("/admin-offres.jsp").forward(request, response);
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
        Long offerId = Long.parseLong(request.getParameter("offerId"));

        if ("delete".equals(action)) {
            jobOfferDAO.delete(offerId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/offres");
    }
}
