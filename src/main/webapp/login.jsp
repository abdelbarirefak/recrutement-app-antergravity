<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Connexion - JobBoard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { "primary": "#f9f506" }
                }
            }
        }
    </script>
</head>
<body class="bg-[#f8f8f5] flex items-center justify-center min-h-screen">

    <div class="bg-white p-8 rounded-2xl shadow-lg max-w-md w-full border border-gray-100">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Bon retour !</h2>
            <p class="text-gray-500 text-sm">Connectez-vous pour accéder à votre espace.</p>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                <span class="block sm:inline"><%= request.getAttribute("errorMessage") %></span>
            </div>
        <% } %>

        <form action="login" method="post" class="space-y-4">
            
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input type="email" name="email" required 
                       class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary shadow-sm"
                       placeholder="exemple@email.com">
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Mot de passe</label>
                <input type="password" name="password" required 
                       class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary shadow-sm"
                       placeholder="••••••••">
            </div>

            <button type="submit" 
                    class="w-full bg-[#f9f506] hover:bg-yellow-300 text-black font-bold py-3 rounded-xl transition-colors shadow-sm">
                Se connecter
            </button>
        </form>

        <p class="mt-4 text-center text-sm text-gray-500">
            Pas encore de compte ? <a href="register.jsp" class="text-black font-bold hover:underline">Inscrivez-vous</a>
        </p>
        
        <p class="mt-4 text-center text-sm text-gray-500">
            <a href="index.jsp" class="hover:underline">← Retour à l'accueil</a>
        </p>
    </div>

</body>
</html>