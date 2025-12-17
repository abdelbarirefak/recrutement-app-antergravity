<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.recrutement.entity.User" %>
<%
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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-slate-50 flex items-center justify-center min-h-screen py-10 px-4">

    <div class="bg-white p-8 rounded-2xl shadow-xl shadow-slate-200/50 max-w-2xl w-full border border-slate-100">
        
        <div class="flex items-center justify-between mb-8">
            <div>
                <h2 class="text-2xl font-bold text-slate-900">Nouvelle Offre</h2>
                <p class="text-slate-500 text-sm mt-1">Attirez les meilleurs talents avec une description claire.</p>
            </div>
            <div class="bg-indigo-50 p-2 rounded-lg text-indigo-600">
                <i data-lucide="pen-tool" class="w-6 h-6"></i>
            </div>
        </div>

        <form action="post-job" method="post" class="space-y-6">
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Intitulé du poste</label>
                    <input type="text" name="title" required placeholder="ex: Développeur Java"
                           class="w-full rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 shadow-sm text-sm py-2.5">
                </div>
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Lieu</label>
                    <div class="relative">
                        <i data-lucide="map-pin" class="absolute left-3 top-2.5 text-slate-400 w-4 h-4"></i>
                        <input type="text" name="location" required placeholder="ex: Paris (ou Remote)"
                               class="w-full pl-9 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 shadow-sm text-sm py-2.5">
                    </div>
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700 mb-1.5">Salaire annuel (Brut)</label>
                <div class="relative">
                    <span class="absolute left-3 top-2.5 text-slate-400 text-sm font-semibold">€</span>
                    <input type="number" name="salary" placeholder="ex: 45000"
                           class="w-full pl-8 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 shadow-sm text-sm py-2.5">
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-700 mb-1.5">Description du poste</label>
                <textarea name="description" rows="6" required placeholder="Détaillez les missions, les compétences requises et les avantages..."
                          class="w-full rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 shadow-sm text-sm leading-relaxed p-3"></textarea>
            </div>

            <div class="flex items-center justify-end gap-3 pt-4 border-t border-slate-100">
                <a href="dashboard.jsp" class="px-4 py-2 text-sm font-medium text-slate-600 hover:text-slate-900 bg-white border border-slate-200 rounded-lg hover:bg-slate-50 transition-colors">
                    Annuler
                </a>
                <button type="submit" 
                        class="px-6 py-2 text-sm font-semibold text-white bg-slate-900 hover:bg-slate-800 rounded-lg shadow-sm transition-all flex items-center gap-2">
                    <i data-lucide="check" class="w-4 h-4"></i> Publier l'offre
                </button>
            </div>
        </form>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>