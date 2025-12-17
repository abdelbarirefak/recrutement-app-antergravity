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
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tableau de bord - JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-slate-50 min-h-screen">

    <nav class="bg-white border-b border-slate-200 sticky top-0 z-30">
        <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex justify-between items-center">
            <div class="flex items-center gap-2">
                <div class="bg-indigo-600 p-1.5 rounded-lg text-white">
                    <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                </div>
                <h1 class="text-lg font-bold text-slate-900">JobBoard</h1>
            </div>
            <div class="flex items-center gap-4">
                <div class="flex items-center gap-2 text-sm text-slate-600 bg-slate-100 px-3 py-1.5 rounded-full">
                    <i data-lucide="user" class="w-4 h-4"></i>
                    <span class="font-medium"><%= user.getEmail() %></span>
                </div>
                <a href="index.jsp" class="text-slate-400 hover:text-red-500 transition-colors" title="Déconnexion">
                    <i data-lucide="log-out" class="w-5 h-5"></i>
                </a>
            </div>
        </div>
    </nav>

    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        
        <div class="mb-10">
            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Bonjour !</h2>
            <p class="text-slate-500 mt-1">
                Espace personnel : <span class="font-semibold text-indigo-600"><%= user.getRole() %></span>
            </p>
        </div>

        <% if (request.getParameter("success") != null) { %>
            <div class="mb-8 p-4 bg-emerald-50 text-emerald-700 rounded-xl border border-emerald-100 flex items-center gap-3 shadow-sm">
                <i data-lucide="check-circle" class="w-5 h-5"></i>
                <span class="font-medium">Opération réussie !</span>
            </div>
        <% } %>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <% if ("CANDIDATE".equals(user.getRole().toString())) { %>
                <a href="jobs" class="group bg-white p-8 rounded-2xl border border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-200 transition-all flex flex-col items-start relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                        <i data-lucide="search" class="w-24 h-24 text-indigo-600"></i>
                    </div>
                    <div class="w-12 h-12 bg-indigo-50 rounded-xl flex items-center justify-center text-indigo-600 mb-6 group-hover:scale-110 transition-transform">
                        <i data-lucide="briefcase" class="w-6 h-6"></i>
                    </div>
                    <h3 class="text-xl font-bold text-slate-900 mb-2">Chercher un emploi</h3>
                    <p class="text-slate-500 mb-6">Parcourez les dernières offres et postulez en un clic.</p>
                    <span class="text-sm font-semibold text-indigo-600 group-hover:underline">Voir les offres &rarr;</span>
                </a>

                <a href="profile.jsp" class="group bg-white p-8 rounded-2xl border border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-200 transition-all flex flex-col items-start relative overflow-hidden">
                    <div class="w-12 h-12 bg-slate-50 rounded-xl flex items-center justify-center text-slate-600 mb-6 group-hover:scale-110 transition-transform">
                        <i data-lucide="user-cog" class="w-6 h-6"></i>
                    </div>
                    <h3 class="text-xl font-bold text-slate-900 mb-2">Mon Profil</h3>
                    <p class="text-slate-500 mb-6">Mettez à jour votre CV et vos compétences.</p>
                    <span class="text-sm font-semibold text-slate-600 group-hover:text-indigo-600">Modifier &rarr;</span>
                </a>

            <% } else { %>
                <a href="post-job.jsp" class="group bg-slate-900 p-8 rounded-2xl border border-slate-800 shadow-xl shadow-slate-900/10 hover:shadow-2xl transition-all flex flex-col items-start relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-6 opacity-10">
                        <i data-lucide="plus-circle" class="w-24 h-24 text-white"></i>
                    </div>
                    <div class="w-12 h-12 bg-indigo-600 rounded-xl flex items-center justify-center text-white mb-6 group-hover:scale-110 transition-transform">
                        <i data-lucide="plus" class="w-6 h-6"></i>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-2">Publier une offre</h3>
                    <p class="text-slate-400 mb-6">Créez une nouvelle annonce pour trouver vos talents.</p>
                    <span class="text-sm font-semibold text-indigo-400 group-hover:text-white transition-colors">Commencer &rarr;</span>
                </a>

                <a href="candidates" class="group bg-white p-8 rounded-2xl border border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-200 transition-all flex flex-col items-start">
                    <div class="w-12 h-12 bg-slate-50 rounded-xl flex items-center justify-center text-slate-600 mb-6 group-hover:scale-110 transition-transform">
                        <i data-lucide="users" class="w-6 h-6"></i>
                    </div>
                    <h3 class="text-xl font-bold text-slate-900 mb-2">Mes Candidats</h3>
                    <p class="text-slate-500 mb-6">Consultez les profils qui ont postulé à vos offres.</p>
                    <span class="text-sm font-semibold text-slate-600 group-hover:text-indigo-600">Voir la liste &rarr;</span>
                </a>
            <% } %>
        </div>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>