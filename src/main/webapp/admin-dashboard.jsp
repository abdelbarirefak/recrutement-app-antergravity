<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr" class="scroll-smooth">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard Admin | JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    
    <style>
        body { font-family: 'Inter', sans-serif; }
        /* Masquer la scrollbar pour un look plus clean sur la sidebar */
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-gray-50/50 text-gray-800 min-h-screen flex selection:bg-indigo-100 selection:text-indigo-700">

    <aside class="w-72 bg-white border-r border-gray-100 flex flex-col sticky top-0 h-screen shadow-[4px_0_24px_-12px_rgba(0,0,0,0.02)] z-20">
        <div class="p-8 flex items-center gap-3 mb-2">
            <div class="bg-indigo-600 text-white p-2.5 rounded-xl shadow-indigo-200 shadow-lg">
                <i data-lucide="shield-check" class="w-5 h-5 text-white"></i>
            </div>
            <div>
                <h1 class="font-bold text-gray-900 tracking-tight text-lg leading-tight">AdminPanel</h1>
                <p class="text-[10px] uppercase font-bold text-gray-400 tracking-widest">Recrutement</p>
            </div>
        </div>

        <nav class="flex-1 px-6 space-y-1.5 overflow-y-auto no-scrollbar">
            <a href="admin-dashboard.jsp" class="flex items-center gap-3 px-4 py-3.5 text-sm font-semibold text-indigo-600 bg-indigo-50/80 rounded-2xl transition-all duration-200">
                <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                Dashboard
            </a>

            <a href="admin-validations.jsp" class="group flex items-center gap-3 px-4 py-3.5 text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-900 rounded-2xl transition-all duration-200">
                <i data-lucide="user-check" class="w-5 h-5 text-gray-400 group-hover:text-gray-600 transition-colors"></i>
                Validations
            </a>
            <a href="admin-entreprises.jsp" class="group flex items-center gap-3 px-4 py-3.5 text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-900 rounded-2xl transition-all duration-200">
                <i data-lucide="building-2" class="w-5 h-5 text-gray-400 group-hover:text-gray-600 transition-colors"></i>
                Entreprises
            </a>
            <a href="admin-candidats.jsp" class="group flex items-center gap-3 px-4 py-3.5 text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-900 rounded-2xl transition-all duration-200">
                <i data-lucide="users" class="w-5 h-5 text-gray-400 group-hover:text-gray-600 transition-colors"></i>
                Candidats
            </a>
            <a href="admin-offres.jsp" class="group flex items-center gap-3 px-4 py-3.5 text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-900 rounded-2xl transition-all duration-200">
                <i data-lucide="briefcase" class="w-5 h-5 text-gray-400 group-hover:text-gray-600 transition-colors"></i>
                Offres d'emploi
            </a>
        </nav>

        <div class="p-6 mx-2 mt-auto border-t border-gray-50">
            <a href="logout.jsp" class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-red-500 hover:bg-red-50 rounded-2xl transition-all focus:outline-none">
                <i data-lucide="log-out" class="w-4 h-4"></i>
                Déconnexion
            </a>
        </div>
    </aside>

    <main class="flex-1 p-8 lg:p-12 overflow-y-auto">
        
        <header class="mb-12 flex flex-col md:flex-row md:items-end justify-between gap-4">
            <div>
                <h2 class="text-3xl font-bold text-gray-900 tracking-tight">Vue d'ensemble</h2>
                <p class="text-gray-500 mt-2 font-medium">Bienvenue sur votre espace de pilotage.</p>
            </div>
            <div class="text-left md:text-right bg-white px-5 py-2.5 rounded-full border border-gray-100 shadow-sm">
                <span class="text-[10px] font-bold text-gray-400 uppercase tracking-widest mr-2">Date</span>
                <span class="text-sm font-semibold text-gray-700 capitalize" id="current-date"></span>
            </div>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div class="bg-white p-6 rounded-3xl shadow-[0_2px_10px_-4px_rgba(0,0,0,0.05)] border border-gray-100/50 hover:border-amber-200 hover:shadow-amber-100/50 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-start justify-between mb-4">
                    <div class="bg-amber-50 text-amber-600 p-3 rounded-2xl">
                        <i data-lucide="user-plus" class="w-6 h-6"></i>
                    </div>
                    <span class="bg-amber-100 text-amber-700 text-[10px] font-bold px-2 py-1 rounded-full uppercase tracking-wide">Action requise</span>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500 mb-1">Inscriptions en attente</p>
                    <p class="text-4xl font-bold text-gray-900 tracking-tight">${pendingCount}</p>
                </div>
            </div>

            <div class="bg-white p-6 rounded-3xl shadow-[0_2px_10px_-4px_rgba(0,0,0,0.05)] border border-gray-100/50 hover:border-indigo-200 hover:shadow-indigo-100/50 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-start justify-between mb-4">
                    <div class="bg-indigo-50 text-indigo-600 p-3 rounded-2xl">
                        <i data-lucide="building-2" class="w-6 h-6"></i>
                    </div>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500 mb-1">Entreprises actives</p>
                    <p class="text-4xl font-bold text-gray-900 tracking-tight">${enterpriseCount}</p>
                </div>
            </div>

            <div class="bg-white p-6 rounded-3xl shadow-[0_2px_10px_-4px_rgba(0,0,0,0.05)] border border-gray-100/50 hover:border-blue-200 hover:shadow-blue-100/50 hover:-translate-y-1 transition-all duration-300">
                <div class="flex items-start justify-between mb-4">
                    <div class="bg-blue-50 text-blue-600 p-3 rounded-2xl">
                        <i data-lucide="users" class="w-6 h-6"></i>
                    </div>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500 mb-1">Candidats inscrits</p>
                    <p class="text-4xl font-bold text-gray-900 tracking-tight">${candidateCount}</p>
                </div>
            </div>
        </div>

        <section>
            <div class="flex items-center gap-3 mb-6">
                <div class="h-8 w-1 bg-indigo-600 rounded-full"></div>
                <h3 class="text-xl font-bold text-gray-900">Modules de gestion</h3>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">
                <a href="admin/validations" class="group bg-white p-6 rounded-3xl border border-gray-100 shadow-sm hover:border-indigo-300 hover:shadow-md transition-all duration-300 hover:-translate-y-1 relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                        <i data-lucide="user-check" class="w-24 h-24 text-indigo-600 transform rotate-12 translate-x-4 -translate-y-4"></i>
                    </div>
                    <div class="bg-indigo-50 text-indigo-600 p-3 rounded-2xl w-fit mb-4 group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
                        <i data-lucide="user-check" class="w-6 h-6"></i>
                    </div>
                    <h4 class="font-bold text-gray-900 mb-2 text-lg">Validations</h4>
                    <p class="text-gray-500 text-sm leading-relaxed mb-6 font-medium">Modérer les nouvelles inscriptions.</p>
                    <div class="text-indigo-600 text-sm font-bold flex items-center gap-2 group-hover:gap-4 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </div>
                </a>

                <a href="admin/entreprises" class="group bg-white p-6 rounded-3xl border border-gray-100 shadow-sm hover:border-indigo-300 hover:shadow-md transition-all duration-300 hover:-translate-y-1 relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                         <i data-lucide="building-2" class="w-24 h-24 text-indigo-600 transform rotate-12 translate-x-4 -translate-y-4"></i>
                    </div>
                    <div class="bg-gray-100 text-gray-500 p-3 rounded-2xl w-fit mb-4 group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
                        <i data-lucide="building-2" class="w-6 h-6"></i>
                    </div>
                    <h4 class="font-bold text-gray-900 mb-2 text-lg">Entreprises</h4>
                    <p class="text-gray-500 text-sm leading-relaxed mb-6 font-medium">Gérer les comptes recruteurs.</p>
                    <div class="text-indigo-600 text-sm font-bold flex items-center gap-2 group-hover:gap-4 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </div>
                </a>

                <a href="admin/candidats" class="group bg-white p-6 rounded-3xl border border-gray-100 shadow-sm hover:border-indigo-300 hover:shadow-md transition-all duration-300 hover:-translate-y-1 relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                         <i data-lucide="users" class="w-24 h-24 text-indigo-600 transform rotate-12 translate-x-4 -translate-y-4"></i>
                    </div>
                    <div class="bg-gray-100 text-gray-500 p-3 rounded-2xl w-fit mb-4 group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
                        <i data-lucide="users" class="w-6 h-6"></i>
                    </div>
                    <h4 class="font-bold text-gray-900 mb-2 text-lg">Candidats</h4>
                    <p class="text-gray-500 text-sm leading-relaxed mb-6 font-medium">Superviser les profils et CVs.</p>
                    <div class="text-indigo-600 text-sm font-bold flex items-center gap-2 group-hover:gap-4 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </div>
                </a>

                <a href="admin/offres" class="group bg-white p-6 rounded-3xl border border-gray-100 shadow-sm hover:border-indigo-300 hover:shadow-md transition-all duration-300 hover:-translate-y-1 relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                         <i data-lucide="briefcase" class="w-24 h-24 text-indigo-600 transform rotate-12 translate-x-4 -translate-y-4"></i>
                    </div>
                    <div class="bg-gray-100 text-gray-500 p-3 rounded-2xl w-fit mb-4 group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
                        <i data-lucide="briefcase" class="w-6 h-6"></i>
                    </div>
                    <h4 class="font-bold text-gray-900 mb-2 text-lg">Offres</h4>
                    <p class="text-gray-500 text-sm leading-relaxed mb-6 font-medium">Auditer les annonces publiées.</p>
                    <div class="text-indigo-600 text-sm font-bold flex items-center gap-2 group-hover:gap-4 transition-all">
                        Accéder <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </div>
                </a>
            </div>
        </section>
    </main>

    <script>
        // Initialisation des icônes Lucide
        lucide.createIcons();

        // Gestion de la date
        document.getElementById('current-date').textContent = new Date().toLocaleDateString('fr-FR', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    </script>
</body>
</html>