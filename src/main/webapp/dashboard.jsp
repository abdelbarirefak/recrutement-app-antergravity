<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.recrutement.entity.User" %>
<%
    // Security Check: If no user is logged in, kick them back to login page
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Tableau de bord</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-10">

    <div class="max-w-4xl mx-auto bg-white p-8 rounded-xl shadow-md">
        <h1 class="text-3xl font-bold mb-4">Bienvenue, <%= user.getEmail() %> !</h1>
        
        <p class="text-lg text-gray-700">
            Vous êtes connecté en tant que : 
            <span class="font-bold text-blue-600"><%= user.getRole() %></span>
        </p>

        <div class="mt-8 border-t pt-6">
            <h2 class="text-xl font-bold mb-4">Vos actions rapides :</h2>
            
            <% if ("CANDIDATE".equals(user.getRole().toString())) { %>
                <button class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Chercher un emploi</button>
                <button class="bg-gray-200 text-black px-4 py-2 rounded hover:bg-gray-300">Modifier mon profil</button>
            <% } else { %>
                <a href="post-job.jsp" class="bg-yellow-400 text-black px-4 py-2 rounded hover:bg-yellow-500 inline-block">Publier une offre</a>
                <button class="bg-gray-200 text-black px-4 py-2 rounded hover:bg-gray-300">Voir mes candidats</button>
            <% } %>
        </div>

        <div class="mt-10">
            <a href="index.jsp" class="text-red-500 hover:underline">Déconnexion (Retour à l'accueil)</a>
        </div>
    </div>

</body>
</html>