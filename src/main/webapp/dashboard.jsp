<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.recrutement.entity.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Tableau de bord - JobBoard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">

    <nav class="bg-white shadow-sm border-b px-8 py-4 flex justify-between items-center">
        <h1 class="text-xl font-bold">JobBoard</h1>
        <div class="flex gap-4 items-center">
            <span>Bonjour, <%= user.getEmail() %></span>
            <a href="index.jsp" class="text-red-500 text-sm hover:underline">Déconnexion</a>
        </div>
    </nav>

    <div class="max-w-5xl mx-auto mt-10 p-6">
        <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-100">
            <h2 class="text-2xl font-bold mb-2">Espace <%= user.getRole() %></h2>
            <p class="text-gray-500 mb-8">Gérez votre carrière ou vos recrutements depuis cet espace.</p>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <% if ("CANDIDATE".equals(user.getRole().toString())) { %>
                    <a href="jobs" class="block p-6 bg-blue-50 border border-blue-100 rounded-lg hover:bg-blue-100 transition">
                        <h3 class="text-lg font-bold text-blue-800 mb-1">Chercher un emploi</h3>
                        <p class="text-sm text-blue-600">Parcourir toutes les offres disponibles</p>
                    </a>
                    <button class="block p-6 bg-gray-50 border border-gray-100 rounded-lg hover:bg-gray-100 transition">
                        <h3 class="text-lg font-bold text-gray-800 mb-1">Modifier mon profil</h3>
                        <p class="text-sm text-gray-600">Mettre à jour mon CV et mes infos</p>
                    </button>

                <% } else { %>
                    <a href="post-job.jsp" class="block p-6 bg-yellow-50 border border-yellow-100 rounded-lg hover:bg-yellow-100 transition">
                        <h3 class="text-lg font-bold text-yellow-800 mb-1">Publier une offre</h3>
                        <p class="text-sm text-yellow-600">Créer une nouvelle annonce de recrutement</p>
                    </a>
                    <button class="block p-6 bg-gray-50 border border-gray-100 rounded-lg hover:bg-gray-100 transition">
                        <h3 class="text-lg font-bold text-gray-800 mb-1">Voir mes candidats</h3>
                        <p class="text-sm text-gray-600">Consulter les candidatures reçues</p>
                    </button>
                <% } %>
            </div>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="mt-6 p-4 bg-green-100 text-green-700 rounded-lg border border-green-200">
                    Action effectuée avec succès !
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>