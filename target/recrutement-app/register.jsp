<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Inscription - JobBoard</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>

    <body class="bg-slate-50 flex items-center justify-center min-h-screen p-4">

        <div
            class="bg-white p-8 sm:p-10 rounded-2xl shadow-xl shadow-slate-200/50 max-w-md w-full border border-slate-100">

            <div class="text-center mb-8">
                <div
                    class="bg-indigo-50 w-12 h-12 rounded-xl flex items-center justify-center text-indigo-600 mx-auto mb-4">
                    <i data-lucide="user-plus" class="w-6 h-6"></i>
                </div>
                <h2 class="text-2xl font-bold text-slate-900">Créer un compte</h2>
                <p class="text-slate-500 text-sm mt-2">Rejoignez la communauté JobBoard dès aujourd'hui.</p>
            </div>

            <form action="register" method="post" class="space-y-5" id="registerForm">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Email</label>
                    <div class="relative">
                        <i data-lucide="mail" class="absolute left-3 top-2.5 text-slate-400 w-5 h-5"></i>
                        <input type="email" name="email" required
                            class="w-full pl-10 pr-4 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm"
                            placeholder="exemple@email.com">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Mot de passe</label>
                    <div class="relative">
                        <i data-lucide="lock" class="absolute left-3 top-2.5 text-slate-400 w-5 h-5"></i>
                        <input type="password" name="password" required
                            class="w-full pl-10 pr-4 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm"
                            placeholder="••••••••">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Je suis</label>
                    <div class="relative">
                        <i data-lucide="briefcase" class="absolute left-3 top-2.5 text-slate-400 w-5 h-5"></i>
                        <select name="role" id="roleSelect" onchange="toggleFields()"
                            class="w-full pl-10 pr-10 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm bg-white">
                            <option value="CANDIDATE">Un Candidat</option>
                            <option value="ENTERPRISE">Une Entreprise</option>
                        </select>
                    </div>
                </div>

                <!-- Champs Candidat -->
                <div id="candidateFields" class="space-y-4">
                    <div class="grid grid-cols-2 gap-3">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1.5">Prénom</label>
                            <input type="text" name="firstName"
                                class="w-full px-4 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm"
                                placeholder="Jean">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1.5">Nom</label>
                            <input type="text" name="lastName"
                                class="w-full px-4 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm"
                                placeholder="Dupont">
                        </div>
                    </div>
                </div>

                <!-- Champs Entreprise -->
                <div id="enterpriseFields" class="hidden">
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Nom de l'entreprise</label>
                    <input type="text" name="companyName"
                        class="w-full px-4 py-2.5 rounded-lg border-slate-200 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm shadow-sm"
                        placeholder="Acme Inc.">
                </div>

                <div class="bg-amber-50 border border-amber-200 rounded-lg p-3">
                    <p class="text-amber-700 text-xs flex items-start gap-2">
                        <i data-lucide="info" class="w-4 h-4 mt-0.5 flex-shrink-0"></i>
                        <span>Votre inscription sera soumise à validation par un administrateur avant activation.</span>
                    </p>
                </div>

                <button type="submit"
                    class="w-full bg-slate-900 hover:bg-slate-800 text-white font-semibold py-2.5 rounded-lg transition-all shadow-sm">
                    S'inscrire
                </button>
            </form>

            <script>
                function toggleFields() {
                    const role = document.getElementById('roleSelect').value;
                    document.getElementById('candidateFields').classList.toggle('hidden', role !== 'CANDIDATE');
                    document.getElementById('enterpriseFields').classList.toggle('hidden', role !== 'ENTERPRISE');
                }
            </script>

            <div class="mt-8 pt-6 border-t border-slate-100 text-center">
                <p class="text-sm text-slate-500">
                    Déjà un compte ?
                    <a href="login.jsp"
                        class="text-indigo-600 font-semibold hover:text-indigo-700 transition-colors">Connexion</a>
                </p>
                <a href="index.jsp"
                    class="inline-flex items-center gap-1 text-xs text-slate-400 hover:text-slate-600 mt-4 transition-colors">
                    <i data-lucide="arrow-left" class="w-3 h-3"></i> Retour à l'accueil
                </a>
            </div>
        </div>

        <script>lucide.createIcons();</script>
    </body>

    </html>