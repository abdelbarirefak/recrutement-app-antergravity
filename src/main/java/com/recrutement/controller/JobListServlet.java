package com.recrutement.controller;

import com.recrutement.dao.JobOfferDAO;
import com.recrutement.entity.JobOffer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/jobs")
public class JobListServlet extends HttpServlet {
    
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer toutes les offres depuis la base de données
        List<JobOffer> offers = jobOfferDAO.findAll();
        
        // Les envoyer à la JSP
        request.setAttribute("jobList", offers);
        request.getRequestDispatcher("job-list.jsp").forward(request, response);
    }
}