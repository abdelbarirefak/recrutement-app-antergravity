package com.recrutement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
// IMPORTANTS : On utilise jakarta.* au lieu de javax.*
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/JobServlet")
public class JobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Encodage et Session
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        // On récupère l'ID du recruteur stocké en session
        Integer recruiterId = (Integer) session.getAttribute("userId");

        // Sécurité : Si l'utilisateur n'est pas connecté, redirection login
        if (recruiterId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Récupération des données du formulaire HTML
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String contract = request.getParameter("contract");
        String description = request.getParameter("description");
        
        // Pour l'instant, on met un nom d'entreprise par défaut ou on récupère le nom du recruteur
        // Vous pourrez améliorer ça plus tard avec une requête SELECT sur la table enterprises
        String companyName = "Entreprise (ID " + recruiterId + ")";

        // 3. Insertion en Base de Données
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // ATTENTION : Vérifiez bien votre mot de passe (ici vide "")
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/recrutement_db", "root", ""); 

            String sql = "INSERT INTO jobs (recruiter_id, title, company_name, location, contract_type, description) VALUES (?, ?, ?, ?, ?, ?)";
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ps.setString(2, title);
            ps.setString(3, companyName);
            ps.setString(4, location);
            ps.setString(5, contract);
            ps.setString(6, description);

            int result = ps.executeUpdate();

            // 4. Succès -> Redirection vers le dashboard avec paramètre
            if (result > 0) {
                response.sendRedirect("dashboard.jsp?success=JobPosted");
            } else {
                response.sendRedirect("dashboard.jsp?error=NoInsert");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Affiche l'erreur dans l'URL pour débugger facilement (pas recommandé en prod, mais utile ici)
            response.sendRedirect("dashboard.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } finally {
            // Fermeture propre des ressources
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}