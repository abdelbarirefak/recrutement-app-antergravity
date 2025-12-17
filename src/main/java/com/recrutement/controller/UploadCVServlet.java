package com.recrutement.controller;

import com.recrutement.dao.CandidateDAO;
import com.recrutement.entity.Candidate;
import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * Servlet pour l'upload de CV (PDF) par les candidats.
 */
@WebServlet("/profile/upload-cv")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class UploadCVServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/cv";
    private CandidateDAO candidateDAO = new CandidateDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null || loggedUser.getRole() != Role.CANDIDATE) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer le profil candidat
        Candidate candidate = candidateDAO.findByUserId(loggedUser.getId());
        if (candidate == null) {
            request.setAttribute("error", "Profil candidat introuvable. Complétez d'abord votre profil.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        // Créer le répertoire d'upload si nécessaire
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Récupérer le fichier
        Part filePart = request.getPart("cvFile");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Veuillez sélectionner un fichier PDF.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        // Vérifier l'extension
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!originalFileName.toLowerCase().endsWith(".pdf")) {
            request.setAttribute("error", "Seuls les fichiers PDF sont acceptés.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        // Générer un nom unique pour éviter les conflits
        String uniqueFileName = "cv_" + candidate.getId() + "_" + UUID.randomUUID().toString().substring(0, 8) + ".pdf";
        String filePath = uploadFilePath + File.separator + uniqueFileName;

        // Sauvegarder le fichier
        filePart.write(filePath);

        // Mettre à jour le chemin dans la BDD
        candidate.setCvFilePath(UPLOAD_DIR + "/" + uniqueFileName);
        candidateDAO.save(candidate);

        response.sendRedirect(request.getContextPath() + "/profile.jsp?cvUploaded=success");
    }
}
