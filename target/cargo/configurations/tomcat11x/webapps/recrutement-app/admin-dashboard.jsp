<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.recrutement.entity.RegistrationRequest, com.recrutement.entity.Application" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="utf-8" />
            <title>Administration - JobBoard</title>
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

        <body class="bg-gradient-to-br from-slate-50 to-slate-100 min-h-screen">

            <!-- Navbar -->
            <nav class="bg-white shadow-sm border-b border-slate-200">
                <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                    <div class="flex items-center gap-3">
                        <div class="bg-indigo-600 text-white p-2 rounded-lg">
                            <i data-lucide="shield-check" class="w-6 h-6"></i>
                        </div>
                        <span class="text-xl font-bold text-slate-900">Administration JobBoard</span>
                    </div>
                    <a href="logout"
                        class="text-red-600 hover:bg-red-50 px-4 py-2 rounded-lg font-medium transition flex items-center gap-2">
                        <i data-lucide="log-out" class="w-4 h-4"></i> Déconnexion
                    </a>
                </div>
            </nav>

            <div class="max-w-7xl mx-auto px-6 py-8">

                <!-- Stats Cards -->
                <% List<RegistrationRequest> pendingReqs = (List<RegistrationRequest>)
                        request.getAttribute("pendingRequests");
                        List<Application> pendingApps = (List<Application>) request.getAttribute("pendingApplications");
                                int pendingCount = pendingReqs != null ? pendingReqs.size() : 0;
                                int appCount = pendingApps != null ? pendingApps.size() : 0;
                                %>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                                    <div class="bg-white rounded-2xl shadow-sm p-6 border border-amber-200">
                                        <div class="flex items-center gap-4">
                                            <div class="bg-amber-100 text-amber-600 p-3 rounded-xl">
                                                <i data-lucide="user-plus" class="w-8 h-8"></i>
                                            </div>
                                            <div>
                                                <div class="text-3xl font-bold text-slate-900">
                                                    <%= pendingCount %>
                                                </div>
                                                <div class="text-sm text-slate-500">Inscriptions en attente</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bg-white rounded-2xl shadow-sm p-6 border border-purple-200">
                                        <div class="flex items-center gap-4">
                                            <div class="bg-purple-100 text-purple-600 p-3 rounded-xl">
                                                <i data-lucide="file-check" class="w-8 h-8"></i>
                                            </div>
                                            <div>
                                                <div class="text-3xl font-bold text-slate-900">
                                                    <%= appCount %>
                                                </div>
                                                <div class="text-sm text-slate-500">Candidatures à valider</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bg-white rounded-2xl shadow-sm p-6 border border-emerald-200">
                                        <div class="flex items-center gap-4">
                                            <div class="bg-emerald-100 text-emerald-600 p-3 rounded-xl">
                                                <i data-lucide="calendar" class="w-8 h-8"></i>
                                            </div>
                                            <div>
                                                <div class="text-3xl font-bold text-slate-900">—</div>
                                                <div class="text-sm text-slate-500">Entretiens à planifier</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Main Navigation Cards -->
                                <h2 class="text-lg font-bold text-slate-800 mb-4">Gestion des Utilisateurs</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">

                                    <!-- Gestion Entreprises -->
                                    <a href="admin/entreprises"
                                        class="group bg-white rounded-2xl shadow-sm p-8 border border-slate-200 hover:shadow-lg hover:border-indigo-300 transition-all">
                                        <div class="flex items-start gap-4">
                                            <div
                                                class="bg-indigo-100 text-indigo-600 p-4 rounded-2xl group-hover:bg-indigo-600 group-hover:text-white transition-colors">
                                                <i data-lucide="building-2" class="w-10 h-10"></i>
                                            </div>
                                            <div class="flex-1">
                                                <h3
                                                    class="text-xl font-bold text-slate-900 mb-2 group-hover:text-indigo-600 transition-colors">
                                                    Gestion des Entreprises
                                                </h3>
                                                <p class="text-slate-500 text-sm mb-4">
                                                    Validez les inscriptions des recruteurs, visualisez leurs offres
                                                    d'emploi et gérez leurs comptes.
                                                </p>
                                                <div
                                                    class="flex items-center gap-2 text-indigo-600 font-medium text-sm">
                                                    Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>

                                    <!-- Gestion Candidats -->
                                    <a href="admin/candidats"
                                        class="group bg-white rounded-2xl shadow-sm p-8 border border-slate-200 hover:shadow-lg hover:border-blue-300 transition-all">
                                        <div class="flex items-start gap-4">
                                            <div
                                                class="bg-blue-100 text-blue-600 p-4 rounded-2xl group-hover:bg-blue-600 group-hover:text-white transition-colors">
                                                <i data-lucide="users" class="w-10 h-10"></i>
                                            </div>
                                            <div class="flex-1">
                                                <h3
                                                    class="text-xl font-bold text-slate-900 mb-2 group-hover:text-blue-600 transition-colors">
                                                    Gestion des Candidats
                                                </h3>
                                                <p class="text-slate-500 text-sm mb-4">
                                                    Validez les inscriptions des candidats, consultez leurs profils et
                                                    gérez leurs candidatures.
                                                </p>
                                                <div class="flex items-center gap-2 text-blue-600 font-medium text-sm">
                                                    Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>

                                <!-- Quick Actions -->
                                <h2 class="text-lg font-bold text-slate-800 mb-4">Actions Rapides</h2>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                                    <a href="admin/registrations"
                                        class="bg-white rounded-xl p-5 border border-slate-200 hover:shadow-md transition-all flex items-center gap-3">
                                        <div class="bg-amber-100 text-amber-600 p-2 rounded-lg">
                                            <i data-lucide="user-check" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-slate-900">Demandes d'Inscription</div>
                                            <div class="text-xs text-slate-500">Approuver ou refuser</div>
                                        </div>
                                    </a>

                                    <a href="admin/applications"
                                        class="bg-white rounded-xl p-5 border border-slate-200 hover:shadow-md transition-all flex items-center gap-3">
                                        <div class="bg-purple-100 text-purple-600 p-2 rounded-lg">
                                            <i data-lucide="eye" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-slate-900">Révéler Identités</div>
                                            <div class="text-xs text-slate-500">Valider candidatures anonymes</div>
                                        </div>
                                    </a>

                                    <a href="admin/interviews"
                                        class="bg-white rounded-xl p-5 border border-slate-200 hover:shadow-md transition-all flex items-center gap-3">
                                        <div class="bg-emerald-100 text-emerald-600 p-2 rounded-lg">
                                            <i data-lucide="video" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-slate-900">Planifier Entretiens</div>
                                            <div class="text-xs text-slate-500">Créer liens Google Meet</div>
                                        </div>
                                    </a>
                                </div>

            </div>

            <script>lucide.createIcons();</script>
        </body>

        </html>