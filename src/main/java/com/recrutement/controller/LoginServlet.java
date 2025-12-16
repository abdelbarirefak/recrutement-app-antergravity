package com.recrutement.controller;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just show the login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // 1. Check credentials using the Service
            User user = userService.login(email, password);

            if (user != null) {
                // 2. SUCCESS: Create a Session
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user); // Save user in session

                // 3. Redirect to the Dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // 4. FAILURE: Reload login page with an error message
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Server Error");
        }
    }
}