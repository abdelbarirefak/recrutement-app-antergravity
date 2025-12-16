<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.recrutement.entity.JobOffer" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Offres d'emploi</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-10">
    <div class="max-w-6xl mx-auto">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold">Toutes les offres d'emploi</h1>
            <a href="dashboard.jsp" class="text-blue-600 hover:underline">Retour au tableau de bord</a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <% 
                List<JobOffer> offers = (List<JobOffer>) request.getAttribute("jobList");
                if (offers != null && !offers.isEmpty()) {
                    for (JobOffer offer : offers) {
            %>
            <div class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
                <h3 class="text-xl font-bold text-gray-800 mb-2"><%= offer.getTitle() %></h3>
                <p class="text-sm text-gray-500 mb-4"><%= offer.getLocation() %></p>
                <div class="flex justify-between items-center">
                    <span class="bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full"><%= offer.getStatus() %></span>
                    <button class="text-blue-600 font-bold hover:underline">Voir détails</button>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <p class="text-gray-500">Aucune offre disponible pour le moment.</p>
            <% } %>
        </div>
    </div>
</body>
</html>