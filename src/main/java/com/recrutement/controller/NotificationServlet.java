package com.recrutement.controller;

import com.recrutement.dao.NotificationDAO;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * API Servlet pour les notifications.
 * Utilisé par le script JS pour interroger le nombre de notifications non-lues.
 */
@WebServlet("/notifications/count")
public class NotificationServlet extends HttpServlet {

    private NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();

        if (session == null || session.getAttribute("loggedUser") == null) {
            out.print("{\"count\": 0}");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        Long count = notificationDAO.countUnreadByUserId(user.getId());

        out.print("{\"count\": " + count + "}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        String action = request.getParameter("action");

        if ("markAllRead".equals(action)) {
            notificationDAO.markAllAsRead(user.getId());
        } else if ("markRead".equals(action)) {
            Long notifId = Long.parseLong(request.getParameter("id"));
            notificationDAO.markAsRead(notifId);
        }

        response.setStatus(HttpServletResponse.SC_OK);
    }
}
