package com.recrutement.controller;

import com.recrutement.dao.InterviewSlotDAO;
import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * Servlet pour la gestion des créneaux d'entretien par les entreprises.
 */
@WebServlet("/enterprise/slots")
public class InterviewSlotServlet extends HttpServlet {

    private InterviewSlotDAO slotDAO = new InterviewSlotDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null || loggedUser.getRole() != Role.ENTERPRISE) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Enterprise enterprise = enterpriseDAO.findByUserId(loggedUser.getId());
        if (enterprise == null) {
            response.sendRedirect(request.getContextPath() + "/profile.jsp");
            return;
        }

        List<InterviewSlot> slots = slotDAO.findByEnterpriseId(enterprise.getId());
        request.setAttribute("slots", slots);
        request.setAttribute("enterprise", enterprise);

        request.getRequestDispatcher("/enterprise-slots.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null || loggedUser.getRole() != Role.ENTERPRISE) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Enterprise enterprise = enterpriseDAO.findByUserId(loggedUser.getId());
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

            InterviewSlot slot = new InterviewSlot(date, startTime, endTime, enterprise);
            slotDAO.save(slot);

        } else if ("delete".equals(action)) {
            Long slotId = Long.parseLong(request.getParameter("slotId"));
            slotDAO.delete(slotId);
        }

        response.sendRedirect(request.getContextPath() + "/enterprise/slots");
    }
}
