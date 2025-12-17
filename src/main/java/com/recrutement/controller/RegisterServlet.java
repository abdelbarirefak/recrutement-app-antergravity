package com.recrutement.controller;

import com.recrutement.dao.RegistrationRequestDAO;
import com.recrutement.entity.RegistrationRequest;
import com.recrutement.entity.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet d'inscription - Crée une RegistrationRequest (inscription différée).
 * L'utilisateur final est créé uniquement après validation par l'admin.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private RegistrationRequestDAO requestDAO = new RegistrationRequestDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer les données du formulaire
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        // Champs supplémentaires pour le profil
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String companyName = request.getParameter("companyName");

        // 2. Convertir le rôle
        Role role = Role.valueOf(roleParam);

        // 3. Créer la demande d'inscription (pas l'utilisateur final)
        RegistrationRequest regRequest = new RegistrationRequest(email, password, role);
        regRequest.setFirstName(firstName);
        regRequest.setLastName(lastName);
        regRequest.setCompanyName(companyName);

        try {
            // 4. Sauvegarder la demande
            requestDAO.save(regRequest);

            // 5. Succès - Redirection avec message d'attente
            response.sendRedirect("login.jsp?registered=pending");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}