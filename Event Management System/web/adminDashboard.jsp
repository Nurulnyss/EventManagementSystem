<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="navbar">
    <h3>EVENT SYSTEM ADMIN</h3>

    <div>
        <a href="index.jsp">Home</a>
        <a href="createEvent.jsp">Create Event</a>
        <a href="manageEvent.jsp">Manage Event</a>
        <a href="registration.jsp">Registration</a>
    </div>
</div>

<div class="dashboard-page">

    <div class="dashboard-title">
        <h1>Admin Dashboard</h1>
        <p>Select a section to manage the event system.</p>
    </div>

    <div class="dashboard-boxes">

        <a href="createEvent.jsp" class="dashboard-box">
            <h3>Create Event</h3>
            <p>Add new event or programme.</p>
        </a>

        <a href="manageEvent.jsp" class="dashboard-box">
            <h3>Manage Event</h3>
            <p>Edit, publish, or delete events.</p>
        </a>

        <a href="registration.jsp" class="dashboard-box">
            <h3>Registration</h3>
            <p>View user registration details.</p>
        </a>

        <a href="index.jsp" class="dashboard-box">
            <h3>Homepage</h3>
            <p>View public homepage.</p>
        </a>

    </div>

</div>

</body>
</html>