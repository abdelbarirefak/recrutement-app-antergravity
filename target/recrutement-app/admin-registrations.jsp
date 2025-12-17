<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.RegistrationRequest" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Demandes d'Inscription - Administration</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-gray-100 min-h-screen p-6">

            <div class="max-w-5xl mx-auto space-y-6">

                <!-- Header -->
                <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-900 flex items-center gap-2">
                            <i data-lucide="user-plus" class="text-indigo-600"></i> Demandes d'Inscription
                        </h1>
                        <p class="text-slate-500 text-sm">Validez ou refusez les nouvelles inscriptions.</p>
                    </div>
                    <a href="admin"
                        class="text-indigo-600 hover:bg-indigo-50 px-4 py-2 rounded-lg font-medium transition flex items-center gap-2">
                        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour au Dashboard
                    </a>
                </div>

                <% List<RegistrationRequest> requests = (List<RegistrationRequest>)
                        request.getAttribute("pendingRequests"); %>

                        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
                            <div class="p-4 bg-amber-50 border-b border-amber-200">
                                <h2 class="font-bold text-amber-800 flex items-center gap-2">
                                    <i data-lucide="clock" class="w-5 h-5"></i>
                                    En Attente de Validation
                                    <span class="bg-amber-200 text-amber-800 text-xs font-bold px-2 py-1 rounded ml-2">
                                        <%= (requests !=null) ? requests.size() : 0 %>
                                    </span>
                                </h2>
                            </div>

                            <table class="w-full text-left text-sm">
                                <thead class="bg-white text-slate-500 border-b">
                                    <tr>
                                        <th class="p-4">Email</th>
                                        <th class="p-4">Rôle</th>
                                        <th class="p-4">Nom / Entreprise</th>
                                        <th class="p-4">Date</th>
                                        <th class="p-4 text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                    <% if(requests !=null && !requests.isEmpty()) { for(RegistrationRequest req :
                                        requests) { %>
                                        <tr class="hover:bg-slate-50">
                                            <td class="p-4">
                                                <div class="font-bold text-slate-900">
                                                    <%= req.getEmail() %>
                                                </div>
                                            </td>
                                            <td class="p-4">
                                                <span class="<%= " CANDIDATE".equals(req.getRole().toString())
                                                    ? "bg-blue-100 text-blue-700" : "bg-purple-100 text-purple-700" %>
                                                    px-2 py-1 rounded text-xs font-medium">
                                                    <%= req.getRole() %>
                                                </span>
                                            </td>
                                            <td class="p-4 text-slate-600">
                                                <% if("CANDIDATE".equals(req.getRole().toString())) { %>
                                                    <%= req.getFirstName() !=null ? req.getFirstName() + " " +
                                                        req.getLastName() : "-" %>
                                                        <% } else { %>
                                                            <%= req.getCompanyName() !=null ? req.getCompanyName() : "-"
                                                                %>
                                                                <% } %>
                                            </td>
                                            <td class="p-4 text-slate-500 text-xs">
                                                <%= req.getCreatedAt() !=null ? req.getCreatedAt().toLocalDate() : "-"
                                                    %>
                                            </td>
                                            <td class="p-4 text-right flex justify-end gap-2">
                                                <form action="admin/registrations" method="POST" style="display:inline">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="id" value="<%= req.getId() %>">
                                                    <button
                                                        class="bg-emerald-600 text-white px-3 py-1.5 rounded hover:bg-emerald-700 flex items-center gap-1 text-xs">
                                                        <i data-lucide="check" class="w-3 h-3"></i> Approuver
                                                    </button>
                                                </form>
                                                <form action="admin/registrations" method="POST" style="display:inline"
                                                    onsubmit="return confirm('Refuser cette inscription ?');">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="id" value="<%= req.getId() %>">
                                                    <button
                                                        class="bg-red-100 text-red-600 px-3 py-1.5 rounded hover:bg-red-200 flex items-center gap-1 text-xs">
                                                        <i data-lucide="x" class="w-3 h-3"></i> Refuser
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                        <% }} else { %>
                                            <tr>
                                                <td colspan="5" class="p-8 text-center text-slate-400">
                                                    <i data-lucide="inbox"
                                                        class="w-12 h-12 mx-auto mb-2 opacity-50"></i>
                                                    <p>Aucune demande en attente.</p>
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