package com.recrutement.controller;

import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import com.recrutement.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

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
                // Créer la session
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);

                // Rediriger selon le rôle
                if (user.getRole() == Role.ADMIN) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("dashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur serveur.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}