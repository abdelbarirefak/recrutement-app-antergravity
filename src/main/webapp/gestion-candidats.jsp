<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.List, com.recrutement.entity.User, com.recrutement.entity.Candidate, com.recrutement.entity.Application, com.recrutement.entity.RegistrationRequest"
        %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Gestion des Candidats - Administration</title>
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
                <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                    <div class="flex items-center gap-4">
                        <a href="admin" class="text-slate-400 hover:text-slate-600 transition">
                            <i data-lucide="arrow-left" class="w-5 h-5"></i>
                        </a>
                        <div class="flex items-center gap-3">
                            <div class="bg-blue-600 text-white p-2 rounded-lg">
                                <i data-lucide="users" class="w-5 h-5"></i>
                            </div>
                            <span class="text-xl font-bold text-slate-900">Gestion des Candidats</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="max-w-7xl mx-auto px-6 py-8 space-y-8">

                <!-- Demandes d'inscription Candidats -->
                <% List<RegistrationRequest> pendingRequests = (List<RegistrationRequest>)
                        request.getAttribute("pendingCandidates"); %>
                        <div class="bg-white rounded-2xl shadow-sm border border-amber-200 overflow-hidden">
                            <div class="p-5 bg-amber-50 border-b border-amber-200 flex items-center justify-between">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="user-plus" class="w-5 h-5 text-amber-600"></i>
                                    <h2 class="font-bold text-amber-800">Demandes d'Inscription en Attente</h2>
                                </div>
                                <span class="bg-amber-200 text-amber-800 text-xs font-bold px-3 py-1 rounded-full">
                                    <%= pendingRequests !=null ? pendingRequests.size() : 0 %>
                                </span>
                            </div>
                            <div class="divide-y divide-slate-100">
                                <% if(pendingRequests !=null && !pendingRequests.isEmpty()) { for(RegistrationRequest
                                    req : pendingRequests) { %>
                                    <div class="p-5 flex items-center justify-between hover:bg-slate-50">
                                        <div class="flex items-center gap-4">
                                            <div class="bg-blue-100 text-blue-600 p-3 rounded-xl">
                                                <i data-lucide="user" class="w-6 h-6"></i>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-slate-900">
                                                    <%= req.getFirstName() !=null ? req.getFirstName() + " " +
                                                        req.getLastName() : "Non renseigné" %>
                                                </div>
                                                <div class="text-sm text-slate-500">
                                                    <%= req.getEmail() %>
                                                </div>
                                                <div class="text-xs text-slate-400">Demande le <%=
                                                        req.getCreatedAt().toLocalDate() %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex gap-2">
                                            <form action="admin/candidats" method="POST" style="display:inline">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="<%= req.getId() %>">
                                                <button
                                                    class="bg-emerald-600 text-white px-4 py-2 rounded-lg hover:bg-emerald-700 flex items-center gap-1 text-sm font-medium">
                                                    <i data-lucide="check" class="w-4 h-4"></i> Accepter
                                                </button>
                                            </form>
                                            <form action="admin/candidats" method="POST" style="display:inline"
                                                onsubmit="return confirm('Refuser cette demande ?');">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="hidden" name="id" value="<%= req.getId() %>">
                                                <button
                                                    class="bg-red-100 text-red-600 px-4 py-2 rounded-lg hover:bg-red-200 flex items-center gap-1 text-sm font-medium">
                                                    <i data-lucide="x" class="w-4 h-4"></i> Refuser
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                    <% }} else { %>
                                        <div class="p-8 text-center text-slate-400">
                                            <i data-lucide="inbox" class="w-12 h-12 mx-auto mb-2 opacity-50"></i>
                                            <p>Aucune demande d'inscription en attente.</p>
                                        </div>
                                        <% } %>
                            </div>
                        </div>

                        <!-- Candidats Actifs -->
                        <% List<User> candidates = (List<User>) request.getAttribute("candidates"); %>
                                <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
                                    <div
                                        class="p-5 bg-slate-50 border-b border-slate-200 flex items-center justify-between">
                                        <div class="flex items-center gap-3">
                                            <i data-lucide="users" class="w-5 h-5 text-blue-600"></i>
                                            <h2 class="font-bold text-slate-800">Candidats Actifs</h2>
                                        </div>
                                        <span
                                            class="bg-blue-100 text-blue-800 text-xs font-bold px-3 py-1 rounded-full">
                                            <%= candidates !=null ? candidates.size() : 0 %>
                                        </span>
                                    </div>
                                    <table class="w-full text-left text-sm">
                                        <thead class="bg-slate-50 text-slate-500 border-b">
                                            <tr>
                                                <th class="p-4">Candidat</th>
                                                <th class="p-4">Email</th>
                                                <th class="p-4">Statut</th>
                                                <th class="p-4 text-right">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% if(candidates !=null) { for(User u : candidates) { %>
                                                <tr class="hover:bg-slate-50">
                                                    <td class="p-4">
                                                        <div class="flex items-center gap-3">
                                                            <div class="bg-blue-100 text-blue-600 p-2 rounded-lg">
                                                                <i data-lucide="user" class="w-4 h-4"></i>
                                                            </div>
                                                            <span class="font-medium text-slate-900">ID: <%= u.getId()
                                                                    %></span>
                                                        </div>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= u.getEmail() %>
                                                    </td>
                                                    <td class="p-4">
                                                        <% if(u.isValidated()) { %>
                                                            <span
                                                                class="bg-emerald-100 text-emerald-700 px-2 py-1 rounded text-xs font-medium">Actif</span>
                                                            <% } else { %>
                                                                <span
                                                                    class="bg-orange-100 text-orange-700 px-2 py-1 rounded text-xs font-medium">En
                                                                    attente</span>
                                                                <% } %>
                                                    </td>
                                                    <td class="p-4 text-right">
                                                        <form action="admin/candidats" method="POST"
                                                            style="display:inline"
                                                            onsubmit="return confirm('Supprimer ce candidat ?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="<%= u.getId() %>">
                                                            <button
                                                                class="text-red-600 hover:bg-red-50 px-3 py-1 rounded text-xs font-medium">
                                                                Supprimer
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <% }} %>
                                        </tbody>
                                    </table>
                                </div>

            </div>
            <script>lucide.createIcons();</script>
        </body>

        </html>