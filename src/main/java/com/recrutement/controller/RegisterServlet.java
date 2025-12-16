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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Retrieve data from the HTML form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role"); // e.g., "CANDIDATE" or "ENTERPRISE"

        // 2. Convert the role string to our Enum
        Role role = Role.valueOf(roleParam); 

        // 3. Create the User object
        User newUser = new User(email, password, role);

        try {
            // 4. Call the Service to save the user
            userService.registerUser(newUser);

            // 5. Success! Redirect to a success page or login page
            // For now, we just print a success message to the browser
            response.getWriter().write("<h1>Registration Successful!</h1><a href='index.html'>Go Home</a>");
            
        } catch (IllegalArgumentException e) {
            // 6. If validation fails (e.g. weak password), show the error
            response.getWriter().write("<h1>Error: " + e.getMessage() + "</h1><a href='register.jsp'>Try Again</a>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<h1>System Error. Please try again later.</h1>");
        }
    }
    
    // This handles GET requests (when someone just visits /register url directly)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the user to the registration form (we will create this next)
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}