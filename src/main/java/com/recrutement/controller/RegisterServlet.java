package com.recrutement.controller;

import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import com.recrutement.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// This annotation tells the server: "If someone goes to /register, run this code."
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve data from the HTML form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role"); // e.g., "CANDIDATE" or "ENTERPRISE"

        // 2. Convert the role string to our Enum
        Role role = Role.valueOf(roleParam);

        // 3. Create the User object
        User newUser = new User(email, password, role);

        try {
            // 4. Call the Service to save the user AND create their profile
            userService.registerUser(newUser);

            // 5. Success! Redirect to login page with success message
            response.sendRedirect("login.jsp?registered=success");

        } catch (IllegalArgumentException e) {
            // 6. Validation error (e.g. weak password)
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur système. Veuillez réessayer.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // This handles GET requests (when someone just visits /register url directly)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward the user to the registration form (we will create this next)
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}