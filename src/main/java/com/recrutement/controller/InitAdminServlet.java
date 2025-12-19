package com.recrutement.controller;

import com.recrutement.dao.UserDAO;
import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import com.recrutement.entity.UserStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet pour initialiser un compte admin (à utiliser une seule fois).
 * L'admin est créé avec status VALIDE.
 */
@WebServlet("/init-admin")
public class InitAdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        User existingAdmin = userDAO.findByEmail("admin@test.com");

        if (existingAdmin != null) {
            out.println("<html><body style='font-family:sans-serif;padding:40px;'>");
            out.println("<h2>✅ Admin existe déjà</h2>");
            out.println("<p><strong>Email:</strong> admin@test.com</p>");
            out.println("<p><strong>Status:</strong> " + existingAdmin.getStatus() + "</p>");
            out.println(
                    "<br><a href='login.jsp' style='padding:10px 20px;background:#4f46e5;color:white;text-decoration:none;border-radius:5px;'>Se connecter</a>");
            out.println("</body></html>");
            return;
        }

        // Créer l'admin avec status VALIDE (pas besoin de validation)
        User admin = new User("admin@test.com", "admin123", Role.ADMIN);
        admin.setStatus(UserStatus.VALIDE);
        userDAO.save(admin);

        out.println("<html><body style='font-family:sans-serif;padding:40px;'>");
        out.println("<h2>✅ Admin créé avec succès !</h2>");
        out.println("<p><strong>Email:</strong> admin@test.com</p>");
        out.println("<p><strong>Mot de passe:</strong> admin123</p>");
        out.println("<p><strong>Status:</strong> VALIDE</p>");
        out.println(
                "<br><a href='login.jsp' style='padding:10px 20px;background:#4f46e5;color:white;text-decoration:none;border-radius:5px;'>Se connecter</a>");
        out.println("</body></html>");
    }
}
