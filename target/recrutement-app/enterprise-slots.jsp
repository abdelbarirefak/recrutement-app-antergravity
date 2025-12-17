<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.InterviewSlot, com.recrutement.entity.Enterprise" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Mes Créneaux d'Entretien</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-gray-100 min-h-screen p-6">

            <div class="max-w-4xl mx-auto space-y-6">

                <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-900 flex items-center gap-2">
                            <i data-lucide="calendar-plus" class="text-purple-600"></i> Mes Créneaux d'Entretien
                        </h1>
                        <p class="text-slate-500 text-sm">Définissez vos disponibilités pour les entretiens.</p>
                    </div>
                    <a href="dashboard.jsp"
                        class="text-indigo-600 hover:bg-indigo-50 px-4 py-2 rounded-lg font-medium transition">
                        <i data-lucide="arrow-left" class="w-4 h-4 inline"></i> Dashboard
                    </a>
                </div>

                <!-- Formulaire ajout -->
                <div class="bg-white rounded-xl shadow-sm p-6 border border-purple-200">
                    <h2 class="font-bold text-purple-800 mb-4">Ajouter un créneau</h2>
                    <form action="enterprise/slots" method="POST" class="flex flex-wrap gap-4 items-end">
                        <input type="hidden" name="action" value="add">
                        <div>
                            <label class="block text-xs text-slate-500 mb-1">Date</label>
                            <input type="date" name="date" required class="border rounded px-3 py-2">
                        </div>
                        <div>
                            <label class="block text-xs text-slate-500 mb-1">Heure début</label>
                            <input type="time" name="startTime" required class="border rounded px-3 py-2">
                        </div>
                        <div>
                            <label class="block text-xs text-slate-500 mb-1">Heure fin</label>
                            <input type="time" name="endTime" required class="border rounded px-3 py-2">
                        </div>
                        <button class="bg-purple-600 text-white px-4 py-2 rounded hover:bg-purple-700">
                            <i data-lucide="plus" class="w-4 h-4 inline"></i> Ajouter
                        </button>
                    </form>
                </div>

                <!-- Liste des créneaux -->
                <% List<InterviewSlot> slots = (List<InterviewSlot>) request.getAttribute("slots"); %>
                        <div class="bg-white rounded-xl shadow-sm border border-slate-200">
                            <div class="p-4 bg-slate-50 border-b border-slate-200">
                                <h2 class="font-bold text-slate-800">Mes Créneaux</h2>
                            </div>
                            <table class="w-full text-sm">
                                <thead class="text-slate-500 border-b">
                                    <tr>
                                        <th class="p-4 text-left">Date</th>
                                        <th class="p-4 text-left">Horaire</th>
                                        <th class="p-4 text-left">Statut</th>
                                        <th class="p-4 text-right">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if(slots !=null) { for(InterviewSlot slot : slots) { %>
                                        <tr class="border-b hover:bg-slate-50">
                                            <td class="p-4">
                                                <%= slot.getDate() %>
                                            </td>
                                            <td class="p-4">
                                                <%= slot.getStartTime() %> - <%= slot.getEndTime() %>
                                            </td>
                                            <td class="p-4">
                                                <% if(slot.isAvailable()) { %>
                                                    <span
                                                        class="bg-emerald-100 text-emerald-700 px-2 py-1 rounded text-xs">Disponible</span>
                                                    <% } else { %>
                                                        <span
                                                            class="bg-red-100 text-red-700 px-2 py-1 rounded text-xs">Réservé</span>
                                                        <% } %>
                                            </td>
                                            <td class="p-4 text-right">
                                                <% if(slot.isAvailable()) { %>
                                                    <form action="enterprise/slots" method="POST"
                                                        style="display:inline">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="slotId" value="<%= slot.getId() %>">
                                                        <button class="text-red-600 text-xs">Supprimer</button>
                                                    </form>
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