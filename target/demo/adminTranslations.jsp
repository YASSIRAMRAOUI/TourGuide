<%@ page import="java.sql.*, database.DatabaseConnection" %>
<%
    Connection conn = DatabaseConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT key, lang, custom_translation FROM translations");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Translations</title>
</head>
<body>
    <h2>Admin - Manage Translations</h2>

    <form action="SaveTranslationServlet" method="post">
        <label for="key">Key:</label>
        <input type="text" name="key" id="key" required>

        <label for="lang">Language:</label>
        <select name="lang" id="lang">
            <option value="en">English</option>
            <option value="es">Español</option>
            <option value="fr">Français</option>
        </select>

        <label for="custom_translation">Custom Translation:</label>
        <textarea name="custom_translation" id="custom_translation" required></textarea>

        <button type="submit">Save Translation</button>
    </form>

    <h3>Existing Translations</h3>
    <table border="1">
        <tr>
            <th>Key</th>
            <th>Language</th>
            <th>Custom Translation</th>
        </tr>
        <%
            while (rs.next()) {
                String key = rs.getString("key");
                String lang = rs.getString("lang");
                String customTranslation = rs.getString("custom_translation");
        %>
        <tr>
            <td><%= key %></td>
            <td><%= lang %></td>
            <td><%= customTranslation %></td>
        </tr>
        <% } %>
    </table>

    <%
        rs.close();
        stmt.close();
        conn.close();
    %>
</body>
</html>
