<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

    <body class="bg-gradient-to-br from-slate-100 to-slate-200 min-h-screen">

        <!-- Navbar -->
        <nav class="bg-white shadow-sm border-b border-slate-200 sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                <div class="flex items-center gap-3">
                    <div class="bg-indigo-600 text-white p-2.5 rounded-xl">
                        <i data-lucide="shield-check" class="w-6 h-6"></i>
                    </div>
                    <div>
                        <span class="text-xl font-bold text-slate-900">Administration</span>
                        <p class="text-xs text-slate-500">JobBoard - Panneau de contrôle</p>
                    </div>
                </div>
                <a href="logout"
                    class="flex items-center gap-2 text-red-600 hover:bg-red-50 px-4 py-2 rounded-lg font-medium transition">
                    <i data-lucide="log-out" class="w-4 h-4"></i> Déconnexion
                </a>
            </div>
        </nav>

        <div class="max-w-7xl mx-auto px-6 py-8">

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
                <div class="bg-white rounded-2xl shadow-sm p-6 border-l-4 border-amber-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm text-slate-500 font-medium">En attente de validation</p>
                            <p class="text-4xl font-bold text-slate-900 mt-1">${pendingCount}</p>
                        </div>
                        <div class="bg-amber-100 text-amber-600 p-3 rounded-xl">
                            <i data-lucide="user-plus" class="w-8 h-8"></i>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-6 border-l-4 border-indigo-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm text-slate-500 font-medium">Entreprises inscrites</p>
                            <p class="text-4xl font-bold text-slate-900 mt-1">${enterpriseCount}</p>
                        </div>
                        <div class="bg-indigo-100 text-indigo-600 p-3 rounded-xl">
                            <i data-lucide="building-2" class="w-8 h-8"></i>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-2xl shadow-sm p-6 border-l-4 border-blue-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm text-slate-500 font-medium">Candidats inscrits</p>
                            <p class="text-4xl font-bold text-slate-900 mt-1">${candidateCount}</p>
                        </div>
                        <div class="bg-blue-100 text-blue-600 p-3 rounded-xl">
                            <i data-lucide="users" class="w-8 h-8"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation Cards -->
            <h2 class="text-lg font-bold text-slate-800 mb-4 flex items-center gap-2">
                <i data-lucide="layout-grid" class="w-5 h-5 text-indigo-600"></i>
                Gestion de la plateforme
            </h2>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

                <!-- Validations -->
                <a href="admin/validations"
                    class="group bg-white rounded-2xl shadow-sm p-6 border border-slate-200 hover:shadow-lg hover:border-amber-300 transition-all">
                    <div
                        class="bg-amber-100 text-amber-600 p-4 rounded-xl w-fit mb-4 group-hover:bg-amber-600 group-hover:text-white transition-colors">
                        <i data-lucide="user-check" class="w-8 h-8"></i>
                    </div>
                    <h3 class="font-bold text-slate-900 text-lg mb-1">Validations</h3>
                    <p class="text-slate-500 text-sm mb-3">Accepter ou refuser les nouvelles inscriptions</p>
                    <span
                        class="text-amber-600 font-medium text-sm flex items-center gap-1 group-hover:gap-2 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </span>
                </a>

                <!-- Entreprises -->
                <a href="admin/entreprises"
                    class="group bg-white rounded-2xl shadow-sm p-6 border border-slate-200 hover:shadow-lg hover:border-indigo-300 transition-all">
                    <div
                        class="bg-indigo-100 text-indigo-600 p-4 rounded-xl w-fit mb-4 group-hover:bg-indigo-600 group-hover:text-white transition-colors">
                        <i data-lucide="building-2" class="w-8 h-8"></i>
                    </div>
                    <h3 class="font-bold text-slate-900 text-lg mb-1">Entreprises</h3>
                    <p class="text-slate-500 text-sm mb-3">Gérer les comptes recruteurs</p>
                    <span
                        class="text-indigo-600 font-medium text-sm flex items-center gap-1 group-hover:gap-2 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </span>
                </a>

                <!-- Candidats -->
                <a href="admin/candidats"
                    class="group bg-white rounded-2xl shadow-sm p-6 border border-slate-200 hover:shadow-lg hover:border-blue-300 transition-all">
                    <div
                        class="bg-blue-100 text-blue-600 p-4 rounded-xl w-fit mb-4 group-hover:bg-blue-600 group-hover:text-white transition-colors">
                        <i data-lucide="users" class="w-8 h-8"></i>
                    </div>
                    <h3 class="font-bold text-slate-900 text-lg mb-1">Candidats</h3>
                    <p class="text-slate-500 text-sm mb-3">Gérer les profils candidats et CV</p>
                    <span
                        class="text-blue-600 font-medium text-sm flex items-center gap-1 group-hover:gap-2 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </span>
                </a>

                <!-- Offres -->
                <a href="admin/offres"
                    class="group bg-white rounded-2xl shadow-sm p-6 border border-slate-200 hover:shadow-lg hover:border-purple-300 transition-all">
                    <div
                        class="bg-purple-100 text-purple-600 p-4 rounded-xl w-fit mb-4 group-hover:bg-purple-600 group-hover:text-white transition-colors">
                        <i data-lucide="briefcase" class="w-8 h-8"></i>
                    </div>
                    <h3 class="font-bold text-slate-900 text-lg mb-1">Offres d'emploi</h3>
                    <p class="text-slate-500 text-sm mb-3">Modérer les annonces publiées</p>
                    <span
                        class="text-purple-600 font-medium text-sm flex items-center gap-1 group-hover:gap-2 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </span>
                </a>

            </div>
        </div>

        <script>lucide.createIcons();</script>
    </body>

    </html>