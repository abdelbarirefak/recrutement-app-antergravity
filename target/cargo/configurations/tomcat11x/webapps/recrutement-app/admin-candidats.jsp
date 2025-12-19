<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.User" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Candidats - Administration</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }
            </style>
        </head>

        <body class="bg-slate-50 min-h-screen">

            <!-- Header -->
            <div class="bg-white shadow-sm border-b border-slate-200">
                <div class="max-w-7xl mx-auto px-6 py-4 flex items-center gap-4">
                    <a href="admin"
                        class="text-slate-400 hover:text-slate-600 transition p-2 hover:bg-slate-100 rounded-lg">
                        <i data-lucide="arrow-left" class="w-5 h-5"></i>
                    </a>
                    <div class="flex items-center gap-3">
                        <div class="bg-blue-600 text-white p-2 rounded-lg">
                            <i data-lucide="users" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <span class="text-xl font-bold text-slate-900">Gestion des Candidats</span>
                            <p class="text-xs text-slate-500">Liste et gestion des profils candidats</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="max-w-7xl mx-auto px-6 py-8">

                <% List<User> candidates = (List<User>) request.getAttribute("candidates"); %>

                        <% if (candidates==null || candidates.isEmpty()) { %>
                            <div class="bg-white rounded-2xl shadow-sm p-12 text-center">
                                <div class="bg-slate-100 text-slate-400 p-4 rounded-full w-fit mx-auto mb-4">
                                    <i data-lucide="users" class="w-12 h-12"></i>
                                </div>
                                <h3 class="text-xl font-bold text-slate-900 mb-2">Aucun candidat inscrit</h3>
                                <p class="text-slate-500">Les candidats apparaîtront ici une fois inscrits.</p>
                            </div>
                            <% } else { %>
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <div
                                        class="p-5 bg-blue-50 border-b border-blue-200 flex justify-between items-center">
                                        <p class="text-blue-800 font-semibold">
                                            <%= candidates.size() %> candidat(s)
                                        </p>
                                    </div>
                                    <table class="w-full">
                                        <thead class="bg-slate-50 text-slate-500 text-sm">
                                            <tr>
                                                <th class="text-left p-4 font-medium">ID</th>
                                                <th class="text-left p-4 font-medium">Email</th>
                                                <th class="text-left p-4 font-medium">Statut</th>
                                                <th class="text-right p-4 font-medium">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% for (User u : candidates) { %>
                                                <tr class="hover:bg-slate-50">
                                                    <td class="p-4">
                                                        <div class="flex items-center gap-3">
                                                            <div class="bg-blue-100 text-blue-600 p-2 rounded-lg">
                                                                <i data-lucide="user" class="w-5 h-5"></i>
                                                            </div>
                                                            <span class="font-medium text-slate-900">#<%= u.getId() %>
                                                                    </span>
                                                        </div>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= u.getEmail() %>
                                                    </td>
                                                    <td class="p-4">
                                                        <% if (u.getStatus().toString().equals("VALIDE")) { %>
                                                            <span
                                                                class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-full text-xs font-medium">Validé</span>
                                                            <% } else { %>
                                                                <span
                                                                    class="bg-amber-100 text-amber-700 px-3 py-1 rounded-full text-xs font-medium">En
                                                                    attente</span>
                                                                <% } %>
                                                    </td>
                                                    <td class="p-4 text-right">
                                                        <form action="admin/candidats" method="POST"
                                                            style="display:inline"
                                                            onsubmit="return confirm('Supprimer ce candidat et son compte ?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                                                            <button
                                                                class="text-red-600 hover:bg-red-50 px-3 py-2 rounded-lg text-sm font-medium flex items-center gap-1">
                                                                <i data-lucide="trash-2" class="w-4 h-4"></i> Supprimer
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>
                                </div>
                                <% } %>

            </div>

            <script>lucide.createIcons();</script>
        </body>

        </html>