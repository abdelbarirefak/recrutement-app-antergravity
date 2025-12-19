package com.recrutement.controller;

import com.recrutement.dao.UserDAO;
import com.recrutement.dao.CandidateDAO;
import com.recrutement.dao.EnterpriseDAO;
import com.recrutement.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;

/**
 * Servlet d'inscription - Crée un User avec statut EN_ATTENTE.
 * Le compte ne sera utilisable qu'après validation par l'admin.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private CandidateDAO candidateDAO = new CandidateDAO();
    private EnterpriseDAO enterpriseDAO = new EnterpriseDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        // Champs profil
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String companyName = request.getParameter("companyName");

        try {
            // Vérifier si l'email existe déjà
            if (userDAO.findByEmail(email) != null) {
                request.setAttribute("errorMessage", "Cette adresse email est déjà utilisée.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Role role = Role.valueOf(roleParam);

            // Hachage du mot de passe avec BCrypt
            String hashedPw = BCrypt.hashpw(password, BCrypt.gensalt());

            // 1. Créer l'utilisateur avec statut EN_ATTENTE
            User newUser = new User(email, hashedPw, role);
            newUser.setStatus(UserStatus.EN_ATTENTE); // Explicite
            userDAO.save(newUser);

            // 2. Créer le profil associé selon le rôle
            if (role == Role.CANDIDATE) {
                Candidate candidate = new Candidate();
                candidate.setFirstName(firstName != null ? firstName : "");
                candidate.setLastName(lastName != null ? lastName : "");
                candidate.setUser(newUser);
                candidateDAO.save(candidate);
            } else if (role == Role.ENTERPRISE) {
                Enterprise enterprise = new Enterprise();
                enterprise.setCompanyName(companyName != null ? companyName : "Entreprise");
                enterprise.setUser(newUser);
                enterpriseDAO.save(enterprise);
            }

            // 3. Redirection avec message d'attente
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