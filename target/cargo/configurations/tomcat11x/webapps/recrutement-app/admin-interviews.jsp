<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.List, com.recrutement.entity.Interview, com.recrutement.entity.Application, com.recrutement.entity.InterviewSlot"
        %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Planification des Entretiens - Administration</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-gray-100 min-h-screen p-6">

            <div class="max-w-6xl mx-auto space-y-6">

                <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-900 flex items-center gap-2">
                            <i data-lucide="calendar" class="text-indigo-600"></i> Planification des Entretiens
                        </h1>
                        <p class="text-slate-500 text-sm">Planifiez les entretiens pour les candidatures acceptées.</p>
                    </div>
                    <a href="admin"
                        class="text-indigo-600 hover:bg-indigo-50 px-4 py-2 rounded-lg font-medium transition flex items-center gap-2">
                        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour
                    </a>
                </div>

                <% List<Application> apps = (List<Application>) request.getAttribute("acceptedApplications"); %>
                        <% List<Interview> interviews = (List<Interview>) request.getAttribute("interviews"); %>

                                <!-- Entretiens planifiés -->
                                <div class="bg-white rounded-xl shadow-sm border border-emerald-200">
                                    <div class="p-4 bg-emerald-50 border-b border-emerald-200">
                                        <h2 class="font-bold text-emerald-800 flex items-center gap-2">
                                            <i data-lucide="check-circle" class="w-5 h-5"></i> Entretiens Planifiés
                                        </h2>
                                    </div>
                                    <div class="p-4">
                                        <% if(interviews !=null && !interviews.isEmpty()) { %>
                                            <table class="w-full text-sm">
                                                <thead class="text-slate-500 border-b">
                                                    <tr>
                                                        <th class="p-2 text-left">Candidat</th>
                                                        <th class="p-2 text-left">Offre</th>
                                                        <th class="p-2 text-left">Date/Heure</th>
                                                        <th class="p-2 text-left">Lien Meet</th>
                                                        <th class="p-2 text-right">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for(Interview i : interviews) { %>
                                                        <tr class="border-b hover:bg-slate-50">
                                                            <td class="p-2">
                                                                <%= i.getApplication().getCandidate().getFirstName() %>
                                                                    <%= i.getApplication().getCandidate().getLastName()
                                                                        %>
                                                            </td>
                                                            <td class="p-2">
                                                                <%= i.getApplication().getJobOffer().getTitle() %>
                                                            </td>
                                                            <td class="p-2">
                                                                <%= i.getSlot().getDate() %> à <%=
                                                                        i.getSlot().getStartTime() %>
                                                            </td>
                                                            <td class="p-2"><a href="<%= i.getMeetLink() %>"
                                                                    target="_blank"
                                                                    class="text-blue-600 underline">Rejoindre</a></td>
                                                            <td class="p-2 text-right">
                                                                <form action="admin/interviews" method="POST"
                                                                    style="display:inline">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <input type="hidden" name="interviewId"
                                                                        value="<%= i.getId() %>">
                                                                    <button
                                                                        class="text-red-600 text-xs">Annuler</button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>
                                            <% } else { %>
                                                <p class="text-slate-400 text-center py-4">Aucun entretien planifié.</p>
                                                <% } %>
                                    </div>
                                </div>

                                <!-- Candidatures acceptées à planifier -->
                                <div class="bg-white rounded-xl shadow-sm border border-blue-200">
                                    <div class="p-4 bg-blue-50 border-b border-blue-200">
                                        <h2 class="font-bold text-blue-800 flex items-center gap-2">
                                            <i data-lucide="users" class="w-5 h-5"></i> Candidatures Acceptées (à
                                            planifier)
                                        </h2>
                                    </div>
                                    <div class="p-4">
                                        <% if(apps !=null && !apps.isEmpty()) { %>
                                            <table class="w-full text-sm">
                                                <thead class="text-slate-500 border-b">
                                                    <tr>
                                                        <th class="p-2 text-left">Candidat</th>
                                                        <th class="p-2 text-left">Offre</th>
                                                        <th class="p-2 text-left">Entreprise</th>
                                                        <th class="p-2 text-right">Planifier</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for(Application app : apps) { %>
                                                        <tr class="border-b hover:bg-slate-50">
                                                            <td class="p-2">
                                                                <%= app.getCandidate().getFirstName() %>
                                                                    <%= app.getCandidate().getLastName() %>
                                                            </td>
                                                            <td class="p-2">
                                                                <%= app.getJobOffer().getTitle() %>
                                                            </td>
                                                            <td class="p-2">
                                                                <%= app.getJobOffer().getEnterprise().getCompanyName()
                                                                    %>
                                                            </td>
                                                            <td class="p-2 text-right">
                                                                <form action="admin/interviews" method="POST"
                                                                    class="flex gap-2 justify-end items-center">
                                                                    <input type="hidden" name="action" value="schedule">
                                                                    <input type="hidden" name="applicationId"
                                                                        value="<%= app.getId() %>">
                                                                    <input type="number" name="slotId"
                                                                        placeholder="ID Créneau"
                                                                        class="border rounded px-2 py-1 w-24 text-xs"
                                                                        required>
                                                                    <input type="text" name="meetLink"
                                                                        placeholder="https://meet.google.com/..."
                                                                        class="border rounded px-2 py-1 w-48 text-xs"
                                                                        required>
                                                                    <button
                                                                        class="bg-indigo-600 text-white px-2 py-1 rounded text-xs">Planifier</button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>
                                            <% } else { %>
                                                <p class="text-slate-400 text-center py-4">Aucune candidature acceptée
                                                    en attente de planification.</p>
                                                <% } %>
                                    </div>
                                </div>

            </div>
            <script>lucide.createIcons();</script>
        </body>

        </html>