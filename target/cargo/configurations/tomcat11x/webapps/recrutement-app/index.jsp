<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.recrutement.dao.JobOfferDAO, com.recrutement.entity.JobOffer, java.util.List" %>

<html lang="fr" class="scroll-smooth">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>JobBoard - Trouvez votre avenir</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Inter', 'sans-serif'] },
                    colors: {
                        slate: { 850: '#151f32' } // Custom dark
                    }
                }
            }
        }
    </script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 text-slate-900 antialiased font-sans flex flex-col min-h-screen">

    <header class="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-slate-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <a href="index.jsp" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
                <div class="bg-indigo-600 p-1.5 rounded-lg text-white">
                    <i data-lucide="briefcase" class="w-5 h-5"></i>
                </div>
                <span class="text-xl font-bold tracking-tight text-slate-900">JobBoard</span>
            </a>

            <nav class="hidden md:flex gap-8 text-sm font-medium text-slate-600">
                <a href="#" class="hover:text-indigo-600 transition-colors">Offres</a>
                <a href="#" class="hover:text-indigo-600 transition-colors">Entreprises</a>
                <a href="#" class="hover:text-indigo-600 transition-colors">Salaires</a>
            </nav>

            <div class="flex items-center gap-3">
                <a href="login.jsp" class="text-sm font-medium text-slate-600 hover:text-slate-900 px-3 py-2">Connexion</a>
                <a href="register.jsp" class="text-sm font-medium bg-slate-900 text-white px-4 py-2 rounded-lg hover:bg-slate-800 transition-all shadow-sm flex items-center gap-2">
                    <i data-lucide="plus" class="w-4 h-4"></i> Publier
                </a>
            </div>
        </div>
    </header>

    <main class="flex-grow">
        <section class="relative pt-20 pb-16 px-4 overflow-hidden">
            <div class="max-w-4xl mx-auto text-center relative z-10">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-50 text-indigo-700 text-xs font-semibold mb-6 border border-indigo-100">
                    <span class="w-2 h-2 rounded-full bg-indigo-600 animate-pulse"></span>
                    Nouvelles offres ajoutées aujourd'hui
                </div>
                <h1 class="text-4xl md:text-6xl font-extrabold text-slate-900 tracking-tight mb-6 leading-tight">
                    Trouvez le job qui <br/><span class="text-indigo-600">donne du sens.</span>
                </h1>
                <p class="text-lg text-slate-600 mb-10 max-w-2xl mx-auto leading-relaxed">
                    Connectez-vous aux meilleures entreprises. Des milliers d'offres d'emploi, de stages et d'alternances mises à jour quotidiennement.
                </p>

                <div class="bg-white p-2 rounded-2xl shadow-xl border border-slate-100 max-w-3xl mx-auto flex flex-col md:flex-row gap-2">
                    <form action="jobs" method="GET" class="flex flex-col md:flex-row w-full gap-2">
                        <div class="relative flex-1 group">
                            <i data-lucide="search" class="absolute left-4 top-3.5 text-slate-400 w-5 h-5 group-focus-within:text-indigo-600 transition-colors"></i>
                            <input name="keyword" type="text" placeholder="Poste, mots-clés..." 
                                class="w-full pl-12 pr-4 py-3 rounded-xl border-none bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-100 placeholder-slate-400 text-slate-900 font-medium transition-all" />
                        </div>
                        <div class="relative flex-1 group">
                            <i data-lucide="map-pin" class="absolute left-4 top-3.5 text-slate-400 w-5 h-5 group-focus-within:text-indigo-600 transition-colors"></i>
                            <input name="location" type="text" placeholder="Ville ou code postal" 
                                class="w-full pl-12 pr-4 py-3 rounded-xl border-none bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-100 placeholder-slate-400 text-slate-900 font-medium transition-all" />
                        </div>
                        <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-xl font-semibold shadow-lg shadow-indigo-200 transition-all flex items-center justify-center gap-2">
                            Rechercher
                        </button>
                    </form>
                </div>
            </div>
        </section>

        <section class="py-16 bg-white border-t border-slate-100">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 class="text-2xl font-bold mb-8 text-slate-900">Dernières opportunités</h2>
                <div class="grid md:grid-cols-3 gap-6">
                    <% 
                    // Récupération des offres via le DAO
                    try {
                        JobOfferDAO jobDao = new JobOfferDAO();
                        List<JobOffer> offers = jobDao.findAll();
                        
                        if(offers != null && !offers.isEmpty()) {
                            int count = 0;
                            for(JobOffer offer : offers) {
                                if(count++ >= 6) break; // Limite à 6 offres
                    %>
                    <div class="border border-slate-200 p-6 rounded-xl hover:shadow-lg transition bg-slate-50 group">
                        <h3 class="font-bold text-lg text-slate-900 group-hover:text-indigo-600 transition-colors"><%= offer.getTitle() %></h3>
                        <p class="text-slate-500 text-sm mb-4 flex items-center gap-1">
                            <i data-lucide="map-pin" class="w-3 h-3"></i> <%= offer.getLocation() %>
                        </p>
                        
                        <div class="flex justify-between items-center mt-4 pt-4 border-t border-slate-200">
                            <span class="text-xs bg-white border border-slate-200 px-2 py-1 rounded text-slate-600 font-medium">Offre Vérifiée</span>
                            <a href="login.jsp" class="text-indigo-600 text-sm font-medium hover:underline flex items-center gap-1">
                                Voir détail <i data-lucide="arrow-right" class="w-3 h-3"></i>
                            </a>
                        </div>
                    </div>
                    <% 
                            }
                        } else {
                    %>
                        <div class="col-span-3 text-center py-8 text-slate-500 italic">
                            Aucune offre disponible pour le moment.
                        </div>
                    <% 
                        }
                    } catch (Exception e) {
                    %>
                        <div class="col-span-3 text-center py-8 text-red-500 bg-red-50 rounded-lg">
                            Impossible de charger les offres (Erreur connexion BDD).
                        </div>
                    <% } %>
                </div>
                
                <div class="text-center mt-12">
                    <a href="register.jsp" class="inline-flex items-center gap-2 px-6 py-3 bg-white border border-slate-300 rounded-full text-sm font-medium text-slate-700 hover:bg-slate-50 hover:text-slate-900 transition-all">
                        Voir toutes les offres <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </a>
                </div>
            </div>
        </section>

        <section class="py-20 bg-slate-50 border-t border-slate-200">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid md:grid-cols-2 gap-8">
                    <div class="group relative overflow-hidden rounded-2xl bg-white hover:bg-indigo-50/50 border border-slate-200 hover:border-indigo-100 transition-all p-8 md:p-12 shadow-sm">
                        <div class="relative z-10">
                            <div class="w-12 h-12 bg-slate-50 rounded-xl shadow-sm flex items-center justify-center text-indigo-600 mb-6">
                                <i data-lucide="user" class="w-6 h-6"></i>
                            </div>
                            <h3 class="text-2xl font-bold text-slate-900 mb-3">Candidat</h3>
                            <p class="text-slate-600 mb-8 max-w-sm">Découvrez des opportunités de carrière et postulez en un clic auprès des meilleures entreprises.</p>
                            <a href="register.jsp?role=CANDIDATE" class="inline-flex items-center gap-2 text-indigo-600 font-semibold group-hover:gap-3 transition-all">
                                Créer un profil <i data-lucide="arrow-right" class="w-4 h-4"></i>
                            </a>
                        </div>
                    </div>

                    <div class="group relative overflow-hidden rounded-2xl bg-slate-900 text-white hover:bg-slate-800 transition-all p-8 md:p-12 shadow-xl">
                        <div class="relative z-10">
                            <div class="w-12 h-12 bg-slate-800 rounded-xl flex items-center justify-center text-indigo-400 mb-6 border border-slate-700">
                                <i data-lucide="building-2" class="w-6 h-6"></i>
                            </div>
                            <h3 class="text-2xl font-bold mb-3">Recruteur</h3>
                            <p class="text-slate-400 mb-8 max-w-sm">Publiez vos offres, gérez les candidatures et trouvez les talents qu'il vous faut.</p>
                            <a href="register.jsp?role=ENTERPRISE" class="inline-flex items-center gap-2 text-white font-semibold group-hover:gap-3 transition-all">
                                Publier une annonce <i data-lucide="arrow-right" class="w-4 h-4"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="bg-white border-t border-slate-200 py-12">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <div class="flex items-center justify-center gap-2 mb-4">
                <div class="bg-slate-900 p-1.5 rounded-lg text-white">
                    <i data-lucide="briefcase" class="w-4 h-4"></i>
                </div>
                <span class="font-bold text-slate-900">JobBoard</span>
            </div>
            <p class="text-slate-500 text-sm">© 2025 JobBoard Inc. Fait avec <i data-lucide="heart" class="w-3 h-3 inline text-red-500 fill-current"></i> en France.</p>
        </div>
    </footer>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>