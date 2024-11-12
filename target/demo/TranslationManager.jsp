<%@ page import="models.TranslationManager, java.util.*, database.DatabaseConnection" %>
<%
    // Get the selected locale from the session or set a default locale
    Locale locale = (Locale) session.getAttribute("lang");
    if (locale == null) {
        locale = new Locale("en", "US"); // Default to English
        session.setAttribute("lang", locale);
    }

    // Initialize TranslationManager and retrieve translations
    TranslationManager translationManager = new TranslationManager();
    String welcomeMessage = translationManager.getTranslation("welcome_message", "Welcome to Our Tour Guide Management System", locale);
    String mainDescription = translationManager.getTranslation("main_description", "Explore new destinations and experiences with our platform.", locale);
%>

<h2 class="text-3xl font-semibold text-gray-800 mb-4"><%= welcomeMessage %></h2>
<p class="text-gray-600 mb-8 leading-relaxed"><%= mainDescription %></p>
