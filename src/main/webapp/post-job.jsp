<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.recrutement.entity.User" %>
<%
    // Sécurité : Seules les Entreprises connectées peuvent voir cette page
    User user = (User) session.getAttribute("loggedUser");
    if (user == null || !"ENTERPRISE".equals(user.getRole().toString())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Publier une offre - JobBoard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
</head>
<body class="bg-[#f8f8f5] flex items-center justify-center min-h-screen py-10">

    <div class="bg-white p-8 rounded-2xl shadow-lg max-w-2xl w-full border border-gray-100">
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Publier une nouvelle offre</h2>
            <p class="text-gray-500 text-sm">Décrivez le poste pour attirer les meilleurs talents.</p>
        </div>

        <form action="post-job" method="post" class="space-y-5">
            
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Intitulé du poste</label>
                    <input type="text" name="title" required placeholder="ex: Développeur Java Senior"
                           class="w-full rounded-lg border-gray-300 focus:ring-[#f9f506] focus:border-[#f9f506]">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Lieu</label>
                    <input type="text" name="location" required placeholder="ex: Paris (ou Remote)"
                           class="w-full rounded-lg border-gray-300 focus:ring-[#f9f506] focus:border-[#f9f506]">
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Salaire (Annuel)</label>
                <input type="number" name="salary" placeholder="ex: 45000"
                       class="w-full rounded-lg border-gray-300 focus:ring-[#f9f506] focus:border-[#f9f506]">
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Description du poste</label>
                <textarea name="description" rows="5" required placeholder="Détaillez les missions et les compétences requises..."
                          class="w-full rounded-lg border-gray-300 focus:ring-[#f9f506] focus:border-[#f9f506]"></textarea>
            </div>

            <div class="flex items-center justify-between pt-4">
                <a href="dashboard.jsp" class="text-gray-500 hover:text-black">Annuler</a>
                <button type="submit" 
                        class="bg-[#f9f506] hover:bg-yellow-300 text-black font-bold py-3 px-8 rounded-xl transition-colors shadow-sm">
                    Publier l'offre
                </button>
            </div>
        </form>
    </div>
</body>
</html>