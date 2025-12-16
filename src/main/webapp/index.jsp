<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html class="light" lang="fr">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>JobBoard - Trouvez votre avenir</title>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Spline+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#f9f506",
                        "background-light": "#f8f8f5",
                        "background-dark": "#23220f",
                        "surface-light": "#ffffff",
                        "surface-dark": "#2c2b18",
                        "text-main": "#181811",
                        "text-muted": "#8c8b5f",
                    },
                    fontFamily: {
                        "display": ["Spline Sans", "sans-serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "1rem", 
                        "lg": "2rem", 
                        "xl": "3rem", 
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
<style>
        /* Custom scrollbar for a cleaner look */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f8f8f5;
        }
        ::-webkit-scrollbar-thumb {
            background: #e6e6db;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #8c8b5f;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-text-main dark:text-white antialiased transition-colors duration-200">
<div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
<header class="sticky top-0 z-50 flex items-center justify-between whitespace-nowrap border-b border-solid border-b-[#e6e6db] dark:border-b-white/10 bg-surface-light/80 dark:bg-background-dark/80 backdrop-blur-md px-6 py-4 lg:px-10">
<div class="flex items-center gap-4 text-text-main dark:text-white">
<div class="size-8 flex items-center justify-center bg-primary rounded-lg text-black">
<span class="material-symbols-outlined">work</span>
</div>
<h2 class="text-text-main dark:text-white text-xl font-bold leading-tight tracking-[-0.015em]">JobBoard</h2>
</div>
<div class="hidden lg:flex flex-1 justify-center gap-8">
<nav class="flex items-center gap-9">
<a class="text-text-main dark:text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Offres</a>
<a class="text-text-main dark:text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Entreprises</a>
<a class="text-text-main dark:text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Salaires</a>
<a class="text-text-main dark:text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Conseils</a>
</nav>
</div>
<div class="flex gap-3">
<a href="login.jsp" class="hidden sm:flex cursor-pointer items-center justify-center overflow-hidden rounded-full h-10 px-6 bg-surface-light dark:bg-surface-dark border border-[#e6e6db] dark:border-white/10 hover:border-primary transition-colors text-text-main dark:text-white text-sm font-bold leading-normal tracking-[0.015em]">
<span class="truncate">Connexion</span>
</a>
<a href="register.jsp" class="flex cursor-pointer items-center justify-center overflow-hidden rounded-full h-10 px-6 bg-primary hover:bg-yellow-300 transition-colors text-[#181811] text-sm font-bold leading-normal tracking-[0.015em]">
<span class="truncate">Publier une offre</span>
</a>
</div>
</header>
<main class="flex-1 flex flex-col">
<section class="px-4 py-6 md:px-10 lg:px-20 xl:px-40">
<div class="flex flex-col gap-6 bg-cover bg-center bg-no-repeat rounded-xl md:rounded-[3rem] items-center justify-center p-8 md:p-20 min-h-[500px] shadow-sm relative overflow-hidden group" data-alt="Diverse team of professionals working together in a bright modern office" style='background-image: url("https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80");'>
<div class="absolute inset-0 bg-black/40 bg-gradient-to-t from-black/80 via-black/20 to-transparent"></div>
<div class="relative z-10 flex flex-col gap-4 text-center max-w-3xl">
<h1 class="text-white text-4xl md:text-6xl font-black leading-tight tracking-[-0.033em]">
                            Trouvez le job qui vous correspond
                        </h1>
<p class="text-white/90 text-lg font-medium leading-normal max-w-2xl mx-auto">
                            Des milliers d'offres d'emploi, de stages et d'alternances mises à jour quotidiennement pour propulser votre carrière.
                        </p>
</div>
<div class="relative z-10 w-full max-w-2xl mt-4">
<form action="jobs" method="GET" class="flex flex-col md:flex-row w-full bg-white rounded-xl md:rounded-full p-2 gap-2 shadow-lg">
<div class="flex flex-1 items-center px-4 py-2 border-b md:border-b-0 md:border-r border-gray-100">
<span class="material-symbols-outlined text-text-muted mr-3">search</span>
<input name="keyword" class="w-full bg-transparent border-none focus:ring-0 text-text-main placeholder:text-text-muted text-base" placeholder="Poste, mots-clés ou entreprise" type="text"/>
</div>
<div class="flex flex-1 items-center px-4 py-2">
<span class="material-symbols-outlined text-text-muted mr-3">location_on</span>
<input name="location" class="w-full bg-transparent border-none focus:ring-0 text-text-main placeholder:text-text-muted text-base" placeholder="Ville ou code postal" type="text"/>
</div>
<button type="submit" class="bg-primary hover:bg-yellow-300 text-black font-bold h-12 px-8 rounded-full transition-colors flex items-center justify-center gap-2">
<span>Rechercher</span>
</button>
</form>
</div>
</div>
</section>
<section class="px-4 py-10 md:px-10 lg:px-20 xl:px-40">
<div class="max-w-[1200px] mx-auto">
<h2 class="text-text-main dark:text-white text-[28px] font-bold leading-tight tracking-[-0.015em] mb-8">Qui êtes-vous ?</h2>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<div class="group flex flex-col items-stretch justify-start rounded-xl overflow-hidden bg-surface-light dark:bg-surface-dark shadow-sm hover:shadow-md transition-shadow border border-[#e6e6db] dark:border-white/5">
<div class="w-full h-48 bg-center bg-no-repeat bg-cover group-hover:scale-105 transition-transform duration-500" data-alt="Person using a laptop in a cafe setting" style='background-image: url("https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80");'></div>
<div class="flex w-full grow flex-col items-stretch justify-center gap-4 p-6">
<div>
<p class="text-text-main dark:text-white text-2xl font-bold leading-tight tracking-[-0.015em]">Candidat</p>
<p class="text-text-muted mt-2 text-base font-normal leading-normal">Découvrez des opportunités de carrière et postulez en un clic.</p>
</div>
<div class="mt-auto pt-2">
<a href="register.jsp?role=CANDIDATE" class="flex w-full md:w-auto cursor-pointer items-center justify-center overflow-hidden rounded-full h-10 px-6 bg-primary hover:bg-yellow-300 transition-colors text-[#181811] text-sm font-bold leading-normal">
<span class="truncate">Voir les offres</span>
</a>
</div>
</div>
</div>
<div class="group flex flex-col items-stretch justify-start rounded-xl overflow-hidden bg-surface-light dark:bg-surface-dark shadow-sm hover:shadow-md transition-shadow border border-[#e6e6db] dark:border-white/5">
<div class="w-full h-48 bg-center bg-no-repeat bg-cover group-hover:scale-105 transition-transform duration-500" data-alt="Meeting room with professionals discussing around a table" style='background-image: url("https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80");'></div>
<div class="flex w-full grow flex-col items-stretch justify-center gap-4 p-6">
<div>
<p class="text-text-main dark:text-white text-2xl font-bold leading-tight tracking-[-0.015em]">Recruteur</p>
<p class="text-text-muted mt-2 text-base font-normal leading-normal">Trouvez les meilleurs talents pour votre entreprise rapidement.</p>
</div>
<div class="mt-auto pt-2">
<a href="register.jsp?role=ENTERPRISE" class="flex w-full md:w-auto cursor-pointer items-center justify-center overflow-hidden rounded-full h-10 px-6 bg-surface-light dark:bg-white/10 border border-[#e6e6db] dark:border-white/10 hover:border-primary hover:bg-background-light dark:hover:bg-white/20 transition-colors text-text-main dark:text-white text-sm font-bold leading-normal">
<span class="truncate">Publier une annonce</span>
</a>
</div>
</div>
</div>
</div>
</div>
</section>
<section class="px-4 py-10 md:px-10 lg:px-20 xl:px-40 bg-white dark:bg-white/5">
<div class="max-w-[1200px] mx-auto">
<div class="flex justify-between items-end mb-8">
<h2 class="text-text-main dark:text-white text-[28px] font-bold leading-tight tracking-[-0.015em]">Dernières offres</h2>
<a class="hidden md:inline-flex items-center gap-1 text-sm font-bold text-text-main dark:text-white underline decoration-primary decoration-2 underline-offset-4 hover:decoration-4 transition-all" href="jobs">
                            Voir tout <span class="material-symbols-outlined text-sm">arrow_forward</span>
</a>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
<div class="bg-background-light dark:bg-background-dark p-6 rounded-lg hover:shadow-lg transition-all duration-300 border border-transparent hover:border-primary/50 group cursor-pointer flex flex-col h-full">
<div class="flex justify-between items-start mb-4">
<div class="w-12 h-12 bg-white rounded-full flex items-center justify-center shadow-sm overflow-hidden p-2">
<span class="text-xl font-bold">S</span>
</div>
<span class="bg-white dark:bg-white/10 text-xs font-bold px-3 py-1 rounded-full text-text-main dark:text-white">CDI</span>
</div>
<h3 class="text-lg font-bold text-text-main dark:text-white mb-1 group-hover:text-primary transition-colors">Product Designer</h3>
<p class="text-text-muted text-sm mb-4">Spotify • Paris, France (Hybride)</p>
<div class="mt-4 pt-4 border-t border-black/5 dark:border-white/10 flex justify-between items-center text-xs font-medium text-text-muted">
<span>Il y a 2h</span>
<span class="text-text-main dark:text-white group-hover:underline">Postuler</span>
</div>
</div>
</div>
</div>
</section>
</main>
<footer class="bg-surface-light dark:bg-surface-dark py-12 px-4 md:px-10 lg:px-20 border-t border-[#e6e6db] dark:border-white/5">
<div class="max-w-[1200px] mx-auto flex flex-col md:flex-row gap-10 justify-between">
<div class="flex flex-col gap-4 max-w-sm">
<div class="flex items-center gap-2 text-text-main dark:text-white">
<div class="size-6 bg-primary rounded text-black flex items-center justify-center">
<span class="material-symbols-outlined text-[16px]">work</span>
</div>
<h2 class="text-lg font-bold">JobBoard</h2>
</div>
<p class="text-text-muted text-sm leading-relaxed">
                            La plateforme de recrutement nouvelle génération qui connecte les meilleurs talents aux entreprises les plus innovantes.
                        </p>
</div>
</div>
<div class="max-w-[1200px] mx-auto mt-12 pt-6 border-t border-black/5 dark:border-white/5 flex flex-col md:flex-row justify-between items-center text-xs text-text-muted">
<p>© 2025 JobBoard Inc. Tous droits réservés.</p>
<p class="mt-2 md:mt-0">Fait avec <span class="text-primary font-bold">♥</span> en France</p>
</div>
</footer>
</div>
</body></html>