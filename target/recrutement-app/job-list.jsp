<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.recrutement.entity.JobOffer" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Offres d'emploi - JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-slate-50 text-slate-900 p-4 sm:p-8 min-h-screen">
    
    <div class="max-w-6xl mx-auto">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 gap-4">
            <div>
                <h1 class="text-3xl font-bold tracking-tight text-slate-900">Offres d'emploi</h1>
                <p class="text-slate-500 mt-1">Explorez les opportunités disponibles.</p>
            </div>
            <a href="dashboard.jsp" class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-medium text-slate-700 hover:bg-slate-50 hover:border-slate-300 transition-all shadow-sm">
                <i data-lucide="arrow-left" class="w-4 h-4"></i> Tableau de bord
            </a>
        </div>

        <div class="grid grid-cols-1 gap-4">
            <% 
                List<JobOffer> offers = (List<JobOffer>) request.getAttribute("jobList");
                if (offers != null && !offers.isEmpty()) {
                    for (JobOffer offer : offers) {
            %>
            <div class="bg-white p-6 rounded-xl border border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-200 transition-all group">
                <div class="flex flex-col sm:flex-row justify-between items-start gap-4">
                    <div class="flex gap-4">
                        <div class="w-12 h-12 bg-indigo-50 rounded-lg flex items-center justify-center text-indigo-600 font-bold text-lg flex-shrink-0">
                            <%= offer.getTitle().substring(0,1).toUpperCase() %>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">
                                <%= offer.getTitle() %>
                            </h3>
                            <div class="flex flex-wrap items-center gap-3 mt-1.5 text-sm text-slate-500">
                                <span class="flex items-center gap-1">
                                    <i data-lucide="building-2" class="w-3.5 h-3.5"></i> 
                                    <%= offer.getEnterprise().getCompanyName() %>
                                </span>
                                <span class="flex items-center gap-1">
                                    <i data-lucide="map-pin" class="w-3.5 h-3.5"></i> 
                                    <%= offer.getLocation() %>
                                </span>
                                <span class="flex items-center gap-1 text-slate-400">
                                    <i data-lucide="clock" class="w-3.5 h-3.5"></i> 
                                    <%= offer.getPostedDate().toLocalDate() %>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex items-center gap-3 w-full sm:w-auto mt-2 sm:mt-0">
                        <% if (offer.getSalary() != null && offer.getSalary() > 0) { %>
                            <span class="px-3 py-1 bg-slate-100 text-slate-700 text-xs font-semibold rounded-full border border-slate-200">
                                <%= String.format("%.0f", offer.getSalary()) %>€ / an
                            </span>
                        <% } %>
                        <span class="px-3 py-1 bg-emerald-50 text-emerald-700 text-xs font-semibold rounded-full border border-emerald-100 flex items-center gap-1">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> <%= offer.getStatus() %>
                        </span>
                    </div>
                </div>
                
                <div class="mt-6 pt-4 border-t border-slate-100 flex justify-between items-center">
                    <p class="text-sm text-slate-500 line-clamp-1 max-w-lg">
                        <%= offer.getDescription() %>
                    </p>
                    <button class="text-indigo-600 text-sm font-semibold hover:text-indigo-800 transition-colors">
                        Voir les détails &rarr;
                    </button>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <div class="text-center py-20 bg-white rounded-xl border border-dashed border-slate-300">
                <div class="mx-auto w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center text-slate-400 mb-4">
                    <i data-lucide="search-x" class="w-8 h-8"></i>
                </div>
                <h3 class="text-lg font-medium text-slate-900">Aucune offre trouvée</h3>
                <p class="text-slate-500 mt-1">Revenez plus tard ou modifiez vos critères.</p>
            </div>
            <% } %>
        </div>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>