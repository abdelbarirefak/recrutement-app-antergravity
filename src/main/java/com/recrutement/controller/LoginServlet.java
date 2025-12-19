package com.recrutement.controller;

import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import com.recrutement.entity.UserStatus;
import com.recrutement.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet de connexion avec contrôle du statut.
 * - ADMIN : connexion directe (pas de validation requise)
 * - CANDIDATE/ENTERPRISE EN_ATTENTE : connexion refusée
 * - CANDIDATE/ENTERPRISE VALIDE : connexion autorisée
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userService.login(email, password);

            if (user != null) {
                // Vérifier le statut pour les non-admins
                if (user.getRole() != Role.ADMIN && user.getStatus() == UserStatus.EN_ATTENTE) {
                    request.setAttribute("errorMessage",
                            "Compte en attente de validation par l'administrateur.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                // Connexion réussie
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);

                // Redirection selon le rôle
                switch (user.getRole()) {
                    case ADMIN:
                        response.sendRedirect("admin");
                        break;
                    case ENTERPRISE:
                        response.sendRedirect("dashboard.jsp");
                        break;
                    case CANDIDATE:
                        response.sendRedirect("dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("dashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur serveur. Veuillez réessayer.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}