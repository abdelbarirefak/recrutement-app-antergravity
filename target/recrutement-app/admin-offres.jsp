<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.JobOffer" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Offres d'emploi - Administration</title>
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
                        <div class="bg-purple-600 text-white p-2 rounded-lg">
                            <i data-lucide="briefcase" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <span class="text-xl font-bold text-slate-900">Modération des Offres</span>
                            <p class="text-xs text-slate-500">Supprimer les offres inappropriées</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="max-w-7xl mx-auto px-6 py-8">

                <% List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offers"); %>

                        <% if (offers==null || offers.isEmpty()) { %>
                            <div class="bg-white rounded-2xl shadow-sm p-12 text-center">
                                <div class="bg-slate-100 text-slate-400 p-4 rounded-full w-fit mx-auto mb-4">
                                    <i data-lucide="briefcase" class="w-12 h-12"></i>
                                </div>
                                <h3 class="text-xl font-bold text-slate-900 mb-2">Aucune offre publiée</h3>
                                <p class="text-slate-500">Les offres d'emploi apparaîtront ici une fois publiées.</p>
                            </div>
                            <% } else { %>
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <div
                                        class="p-5 bg-purple-50 border-b border-purple-200 flex justify-between items-center">
                                        <p class="text-purple-800 font-semibold">
                                            <%= offers.size() %> offre(s) publiée(s)
                                        </p>
                                    </div>
                                    <table class="w-full">
                                        <thead class="bg-slate-50 text-slate-500 text-sm">
                                            <tr>
                                                <th class="text-left p-4 font-medium">Titre</th>
                                                <th class="text-left p-4 font-medium">Entreprise</th>
                                                <th class="text-left p-4 font-medium">Lieu</th>
                                                <th class="text-right p-4 font-medium">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% for (JobOffer offer : offers) { %>
                                                <tr class="hover:bg-slate-50">
                                                    <td class="p-4">
                                                        <div class="flex items-center gap-3">
                                                            <div class="bg-purple-100 text-purple-600 p-2 rounded-lg">
                                                                <i data-lucide="file-text" class="w-5 h-5"></i>
                                                            </div>
                                                            <div>
                                                                <span class="font-medium text-slate-900">
                                                                    <%= offer.getTitle() %>
                                                                </span>
                                                                <p class="text-xs text-slate-400">ID #<%= offer.getId()
                                                                        %>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= offer.getEnterprise() !=null ?
                                                            offer.getEnterprise().getCompanyName() : "N/A" %>
                                                    </td>
                                                    <td class="p-4 text-slate-600">
                                                        <%= offer.getLocation() %>
                                                    </td>
                                                    <td class="p-4 text-right">
                                                        <form action="admin/offres" method="POST" style="display:inline"
                                                            onsubmit="return confirm('Supprimer cette offre ?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="offerId"
                                                                value="<%= offer.getId() %>">
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