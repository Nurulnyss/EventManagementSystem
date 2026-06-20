<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String error = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String password = request.getParameter("password");

        if ("admin123".equals(password)) {
            session.setAttribute("adminLoggedIn", true);
            response.sendRedirect("adminDashboard.jsp");
            return;
        } else {
            error = "Wrong admin password.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="admin-login-page">

    <div class="admin-login-card">

        <h1>Admin Login</h1>
        <p>Enter password to access admin dashboard.</p>

        <% if (error != null) { %>
            <div class="error-box">
                <%= error %>
            </div>
        <% } %>

        <form action="adminLogin.jsp" method="post">
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter admin password" required>
            </div>

            <button type="submit" class="full-btn">
                Login
            </button>
        </form>

        <a href="index.jsp" class="back-link">Back to homepage</a>

    </div>

</div>

</body>
</html>