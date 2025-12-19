<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.User" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Validations - Administration</title>
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
                        <div class="bg-amber-600 text-white p-2 rounded-lg">
                            <i data-lucide="user-check" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <span class="text-xl font-bold text-slate-900">Gestion des Validations</span>
                            <p class="text-xs text-slate-500">Accepter ou refuser les nouvelles inscriptions</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="max-w-7xl mx-auto px-6 py-8">

                <% List<User> pendingUsers = (List<User>) request.getAttribute("pendingUsers"); %>

                        <% if (pendingUsers==null || pendingUsers.isEmpty()) { %>
                            <div class="bg-white rounded-2xl shadow-sm p-12 text-center">
                                <div class="bg-emerald-100 text-emerald-600 p-4 rounded-full w-fit mx-auto mb-4">
                                    <i data-lucide="check-circle" class="w-12 h-12"></i>
                                </div>
                                <h3 class="text-xl font-bold text-slate-900 mb-2">Aucune validation en attente</h3>
                                <p class="text-slate-500">Toutes les inscriptions ont été traitées.</p>
                            </div>
                            <% } else { %>
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <div class="p-5 bg-amber-50 border-b border-amber-200">
                                        <p class="text-amber-800 font-semibold">
                                            <%= pendingUsers.size() %> inscription(s) en attente
                                        </p>
                                    </div>
                                    <table class="w-full">
                                        <thead class="bg-slate-50 text-slate-500 text-sm">
                                            <tr>
                                                <th class="text-left p-4 font-medium">Utilisateur</th>
                                                <th class="text-left p-4 font-medium">Email</th>
                                                <th class="text-left p-4 font-medium">Type</th>
                                                <th class="text-right p-4 font-medium">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% for (User u : pendingUsers) { %>
                                                <tr class="hover:bg-slate-50">
                                                    <td class="p-4">
                                                        <div class="flex items-center gap-3">
                                                            <div class="<%= u.getRole().toString().equals(" CANDIDATE")
                                                                ? "bg-blue-100 text-blue-600"
                                                                : "bg-indigo-100 text-indigo-600" %> p-2 rounded-lg">
                                                                <i data-lucide="<%= u.getRole().toString().equals("
                                                                    CANDIDATE") ? "user" : "building" %>" class="w-5
                                                                    h-5"></i>
                                                            </div>
                                                            <span class="font-medium text-slate-900">ID #<%= u.getId()
                                                                    %></span>
                                                        </div>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= u.getEmail() %>
                                                    </td>
                                                    <td class="p-4">
                                                        <span class="<%= u.getRole().toString().equals(" CANDIDATE")
                                                            ? "bg-blue-100 text-blue-700"
                                                            : "bg-indigo-100 text-indigo-700" %> px-3 py-1 rounded-full
                                                            text-xs font-medium">
                                                            <%= u.getRole().toString().equals("CANDIDATE") ? "Candidat"
                                                                : "Entreprise" %>
                                                        </span>
                                                    </td>
                                                    <td class="p-4 text-right">
                                                        <div class="flex justify-end gap-2 text-right">
                                                            <button
                                                                onclick="handleAction(event, 'accept', <%= u.getId() %>)"
                                                                class="bg-emerald-600 text-white px-4 py-2 rounded-lg hover:bg-emerald-700 flex items-center gap-1 text-sm font-medium">
                                                                <i data-lucide="check" class="w-4 h-4"></i> Accepter
                                                            </button>
                                                            <button
                                                                onclick="handleAction(event, 'refuse', <%= u.getId() %>)"
                                                                class="bg-red-100 text-red-600 px-4 py-2 rounded-lg hover:bg-red-200 flex items-center gap-1 text-sm font-medium">
                                                                <i data-lucide="x" class="w-4 h-4"></i> Refuser
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>
                                </div>
                                <% } %>

            </div>

            <script>
                lucide.createIcons();

                function handleAction(event, action, userId) {
                    event.preventDefault();

                    const row = event.target.closest('tr');
                    const formData = new URLSearchParams();
                    formData.append('action', action);
                    formData.append('userId', userId);
                    formData.append('ajax', 'true');

                    if (action === 'refuse' && !confirm('Refuser et supprimer ce compte ?')) {
                        return;
                    }

                    fetch('validations', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: formData.toString()
                    })
                        .then(response => {
                            if (response.ok) {
                                row.style.transition = 'all 0.5s ease';
                                row.style.opacity = '0';
                                row.style.transform = 'translateX(20px)';
                                setTimeout(() => {
                                    row.remove();
                                    // Optionnel : vérifier s'il reste des lignes, sinon recharger pour afficher le message "vide"
                                    if (document.querySelectorAll('tbody tr').length === 0) {
                                        location.reload();
                                    }
                                }, 500);
                            } else {
                                alert('Erreur lors de l\'action. Veuillez réessayer.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Une erreur est survenue.');
                        });
                }
            </script>
        </body>

        </html>