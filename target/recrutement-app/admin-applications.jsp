<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.Application" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Gestion des Candidatures - Administration</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-gray-100 min-h-screen p-6">

            <div class="max-w-6xl mx-auto space-y-6">

                <!-- Header -->
                <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-900 flex items-center gap-2">
                            <i data-lucide="file-check" class="text-indigo-600"></i> Gestion des Candidatures
                        </h1>
                        <p class="text-slate-500 text-sm">Validez les candidatures pour révéler l'identité aux
                            entreprises.</p>
                    </div>
                    <a href="admin"
                        class="text-indigo-600 hover:bg-indigo-50 px-4 py-2 rounded-lg font-medium transition flex items-center gap-2">
                        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour au Dashboard
                    </a>
                </div>

                <% List<Application> pending = (List<Application>) request.getAttribute("pendingApplications"); %>

                        <!-- Section Candidatures Anonymes -->
                        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-orange-200">
                            <div class="p-4 bg-orange-50 border-b border-orange-200">
                                <h2 class="font-bold text-orange-800 flex items-center gap-2">
                                    <i data-lucide="user-x" class="w-5 h-5"></i>
                                    Candidatures Anonymes (en attente de validation)
                                    <span
                                        class="bg-orange-200 text-orange-800 text-xs font-bold px-2 py-1 rounded ml-2">
                                        <%= (pending !=null) ? pending.size() : 0 %>
                                    </span>
                                </h2>
                                <p class="text-orange-600 text-xs mt-1">L'entreprise ne voit pas l'identité du candidat
                                    tant que vous ne validez pas.</p>
                            </div>

                            <table class="w-full text-left text-sm">
                                <thead class="bg-white text-slate-500 border-b">
                                    <tr>
                                        <th class="p-4">Candidat (Anonyme)</th>
                                        <th class="p-4">Offre</th>
                                        <th class="p-4">Entreprise</th>
                                        <th class="p-4">Date</th>
                                        <th class="p-4">Lettre</th>
                                        <th class="p-4 text-right">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                    <% if(pending !=null && !pending.isEmpty()) { for(Application app : pending) { %>
                                        <tr class="hover:bg-slate-50">
                                            <td class="p-4">
                                                <div class="flex items-center gap-2">
                                                    <div
                                                        class="w-8 h-8 bg-slate-300 rounded-full flex items-center justify-center">
                                                        <i data-lucide="user" class="w-4 h-4 text-slate-500"></i>
                                                    </div>
                                                    <div>
                                                        <div class="font-bold text-slate-500">Candidat #<%=
                                                                app.getCandidate().getId() %>
                                                        </div>
                                                        <div class="text-xs text-slate-400">Identité masquée</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="p-4">
                                                <div class="font-medium text-slate-900">
                                                    <%= app.getJobOffer().getTitle() %>
                                                </div>
                                            </td>
                                            <td class="p-4 text-slate-600">
                                                <%= app.getJobOffer().getEnterprise() !=null ?
                                                    app.getJobOffer().getEnterprise().getCompanyName() : "-" %>
                                            </td>
                                            <td class="p-4 text-slate-500 text-xs">
                                                <%= app.getApplicationDate().toLocalDate() %>
                                            </td>
                                            <td class="p-4">
                                                <% if(app.getCoverLetter() !=null && !app.getCoverLetter().isEmpty()) {
                                                    %>
                                                    <span class="text-emerald-600 text-xs">✓ Oui</span>
                                                    <% } else { %>
                                                        <span class="text-slate-400 text-xs">Non</span>
                                                        <% } %>
                                            </td>
                                            <td class="p-4 text-right">
                                                <form action="admin/applications" method="POST">
                                                    <input type="hidden" name="action" value="reveal_identity">
                                                    <input type="hidden" name="id" value="<%= app.getId() %>">
                                                    <button
                                                        class="bg-indigo-600 text-white px-3 py-1.5 rounded hover:bg-indigo-700 flex items-center gap-1 text-xs">
                                                        <i data-lucide="eye" class="w-3 h-3"></i> Révéler l'identité
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                        <% }} else { %>
                                            <tr>
                                                <td colspan="6" class="p-8 text-center text-slate-400">
                                                    <i data-lucide="check-circle"
                                                        class="w-12 h-12 mx-auto mb-2 opacity-50"></i>
                                                    <p>Toutes les candidatures ont été traitées.</p>
                                                </td>
                                            </tr>
                                            <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Section Toutes les candidatures -->
                        <% List<Application> all = (List<Application>) request.getAttribute("allApplications"); %>
                                <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
                                    <div class="p-4 bg-slate-50 border-b border-slate-200">
                                        <h2 class="font-bold text-slate-800 flex items-center gap-2">
                                            <i data-lucide="list" class="w-5 h-5"></i>
                                            Historique des Candidatures
                                        </h2>
                                    </div>
                                    <table class="w-full text-left text-sm">
                                        <thead class="bg-white text-slate-500 border-b">
                                            <tr>
                                                <th class="p-4">Candidat</th>
                                                <th class="p-4">Offre</th>
                                                <th class="p-4">Statut</th>
                                                <th class="p-4">Validé Admin</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% if(all !=null) { for(Application app : all) { %>
                                                <tr class="hover:bg-slate-50">
                                                    <td class="p-4">
                                                        <% if(app.isAdminValidated()) { %>
                                                            <span class="font-medium text-slate-900">
                                                                <%= app.getCandidate().getFirstName() %>
                                                                    <%= app.getCandidate().getLastName() %>
                                                            </span>
                                                            <% } else { %>
                                                                <span class="text-slate-500 italic">Anonyme</span>
                                                                <% } %>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= app.getJobOffer().getTitle() %>
                                                    </td>
                                                    <td class="p-4">
                                                        <span class="px-2 py-1 rounded text-xs font-medium
                                    <%= " ACCEPTED".equals(app.getStatus().toString())
                                                            ? "bg-emerald-100 text-emerald-700" : "REJECTED"
                                                            .equals(app.getStatus().toString())
                                                            ? "bg-red-100 text-red-700"
                                                            : "bg-yellow-100 text-yellow-700" %>">
                                                            <%= app.getStatus() %>
                                                        </span>
                                                    </td>
                                                    <td class="p-4">
                                                        <% if(app.isAdminValidated()) { %>
                                                            <span class="text-emerald-600"><i data-lucide="check"
                                                                    class="w-4 h-4 inline"></i></span>
                                                            <% } else { %>
                                                                <span class="text-orange-500"><i data-lucide="clock"
                                                                        class="w-4 h-4 inline"></i></span>
                                                                <% } %>
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