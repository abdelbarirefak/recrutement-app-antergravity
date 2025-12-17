<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.recrutement.entity.User" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Administration - JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-gray-100 min-h-screen p-8">

    <div class="max-w-6xl mx-auto">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-slate-900 flex items-center gap-3">
                <i data-lucide="shield-check" class="text-indigo-600"></i>
                Espace Administrateur
            </h1>
            <a href="index.jsp" class="text-slate-500 hover:text-red-600 font-medium flex items-center gap-2">
                <i data-lucide="log-out" class="w-4 h-4"></i> Déconnexion
            </a>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="p-6 border-b border-slate-100">
                <h2 class="text-lg font-semibold text-slate-800">Gestion des Comptes</h2>
                <p class="text-sm text-slate-500">Validez les nouveaux candidats pour qu'ils puissent accéder à la plateforme.</p>
            </div>

            <table class="w-full text-left">
                <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Utilisateur</th>
                        <th class="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Rôle</th>
                        <th class="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Statut</th>
                        <th class="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider text-right">Action</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% 
                    List<User> users = (List<User>) request.getAttribute("userList");
                    if (users != null) {
                        for (User u : users) {
                            // On masque l'admin lui-même de la liste
                            if ("ADMIN".equals(u.getRole().toString())) continue;
                    %>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4">
                            <div class="font-medium text-slate-900"><%= u.getName() %></div>
                            <div class="text-sm text-slate-500"><%= u.getEmail() %></div>
                        </td>
                        <td class="px-6 py-4">
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium <%= "ENTERPRISE".equals(u.getRole().toString()) ? "bg-blue-100 text-blue-800" : "bg-purple-100 text-purple-800" %>">
                                <%= u.getRole() %>
                            </span>
                        </td>
                        <td class="px-6 py-4">
                            <% if (u.isValidated()) { %>
                                <span class="flex items-center text-emerald-600 text-sm font-medium gap-1">
                                    <i data-lucide="check" class="w-4 h-4"></i> Validé
                                </span>
                            <% } else { %>
                                <span class="flex items-center text-orange-600 text-sm font-medium gap-1">
                                    <i data-lucide="clock" class="w-4 h-4"></i> En attente
                                </span>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 text-right">
                            <% if (!u.isValidated()) { %>
                                <form action="admin" method="POST" class="inline">
                                    <input type="hidden" name="userId" value="<%= u.getId() %>">
                                    <input type="hidden" name="action" value="validate">
                                    <button type="submit" class="bg-indigo-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-indigo-700 shadow-sm transition-all flex items-center gap-2 ml-auto">
                                        <i data-lucide="check-circle" class="w-4 h-4"></i> Valider
                                    </button>
                                </form>
                            <% } else { %>
                                <span class="text-slate-400 text-sm">Aucune action</span>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="4" class="px-6 py-8 text-center text-slate-500 italic">
                            Aucun utilisateur trouvé.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>