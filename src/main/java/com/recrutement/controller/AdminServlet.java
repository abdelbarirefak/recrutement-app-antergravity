package com.recrutement.controller;

import com.recrutement.dao.UserDAO;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Vérification de sécurité : Est-ce un ADMIN ?
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null || !"ADMIN".equals(user.getRole().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Récupérer la liste des utilisateurs
        List<User> users = userDAO.findAll(); 
        
        // 3. Envoyer à la page JSP
        request.setAttribute("userList", users);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Action de validation (clic sur le bouton "Valider")
        String action = request.getParameter("action");
        
        if ("validate".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User userToValidate = userDAO.findById(userId);
                
                if (userToValidate != null) {
                    userToValidate.setValidated(true);
                    userDAO.update(userToValidate);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Recharger la page
        response.sendRedirect("admin");
    }
}