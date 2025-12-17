<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.recrutement.entity.JobOffer" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Postuler à une offre</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-gradient-to-br from-indigo-50 to-purple-50 min-h-screen p-6">

            <div class="max-w-2xl mx-auto">

                <% JobOffer job=(JobOffer) request.getAttribute("jobOffer"); %>

                    <% if(job !=null) { %>
                        <div class="bg-white rounded-2xl shadow-lg p-8">

                            <div class="mb-6">
                                <a href="jobs" class="text-indigo-600 text-sm flex items-center gap-1 mb-4">
                                    <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour aux offres
                                </a>
                                <h1 class="text-2xl font-bold text-slate-900 mb-2">
                                    <%= job.getTitle() %>
                                </h1>
                                <div class="flex gap-4 text-sm text-slate-500">
                                    <span class="flex items-center gap-1">
                                        <i data-lucide="building-2" class="w-4 h-4"></i>
                                        <%= job.getEnterprise() !=null ? job.getEnterprise().getCompanyName()
                                            : "Entreprise" %>
                                    </span>
                                    <span class="flex items-center gap-1">
                                        <i data-lucide="map-pin" class="w-4 h-4"></i>
                                        <%= job.getLocation() %>
                                    </span>
                                    <% if(job.getSalary() !=null) { %>
                                        <span class="flex items-center gap-1">
                                            <i data-lucide="banknote" class="w-4 h-4"></i>
                                            <%= String.format("%.0f", job.getSalary()) %> €
                                        </span>
                                        <% } %>
                                </div>
                            </div>

                            <div class="bg-slate-50 rounded-lg p-4 mb-6">
                                <h3 class="font-semibold text-slate-800 mb-2">Description du poste</h3>
                                <p class="text-slate-600 text-sm">
                                    <%= job.getDescription() %>
                                </p>
                            </div>

                            <% if(job.getRequiredSkills() !=null && !job.getRequiredSkills().isEmpty()) { %>
                                <div class="mb-6">
                                    <h3 class="font-semibold text-slate-800 mb-2">Compétences requises</h3>
                                    <div class="flex flex-wrap gap-2">
                                        <% for(String skill : job.getRequiredSkills().split(",")) { %>
                                            <span class="bg-indigo-100 text-indigo-700 px-2 py-1 rounded text-xs">
                                                <%= skill.trim() %>
                                            </span>
                                            <% } %>
                                    </div>
                                </div>
                                <% } %>

                                    <form action="apply" method="POST" class="space-y-4">
                                        <input type="hidden" name="jobId" value="<%= job.getId() %>">

                                        <div>
                                            <label class="block text-sm font-medium text-slate-700 mb-2">Lettre de
                                                motivation</label>
                                            <textarea name="coverLetter" rows="6"
                                                class="w-full border border-slate-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                                                placeholder="Expliquez pourquoi vous êtes le candidat idéal pour ce poste..."></textarea>
                                            <p class="text-xs text-slate-400 mt-1">Optionnel mais recommandé</p>
                                        </div>

                                        <div class="bg-amber-50 border border-amber-200 rounded-lg p-4">
                                            <p class="text-amber-800 text-sm flex items-start gap-2">
                                                <i data-lucide="info" class="w-4 h-4 mt-0.5"></i>
                                                <span>Votre candidature sera anonyme jusqu'à validation par
                                                    l'administration.</span>
                                            </p>
                                        </div>

                                        <button type="submit"
                                            class="w-full bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold py-3 rounded-lg hover:from-indigo-700 hover:to-purple-700 transition flex items-center justify-center gap-2">
                                            <i data-lucide="send" class="w-5 h-5"></i> Envoyer ma candidature
                                        </button>
                                    </form>
                        </div>
                        <% } else { %>
                            <div class="bg-white rounded-2xl shadow-lg p-8 text-center">
                                <i data-lucide="alert-circle" class="w-16 h-16 text-slate-300 mx-auto mb-4"></i>
                                <p class="text-slate-500">Offre introuvable.</p>
                                <a href="jobs" class="text-indigo-600 mt-4 inline-block">Retour aux offres</a>
                            </div>
                            <% } %>

            </div>
            <script>lucide.createIcons();</script>
        </body>

        </html>