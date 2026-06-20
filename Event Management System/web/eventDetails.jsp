<%@page import="com.model.eventDAO"%>
<%@page import="com.bean.EventBean"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    eventDAO dao = new eventDAO();

    EventBean event = dao.getEventById(id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>

    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="navbar">
    <h2>Event Management System</h2>

    <div>
        <a href="index.jsp">Home</a>
    </div>
</div>

<div class="details-container">

    <h1><%= event.getTitle() %></h1>

    <p>
        <strong>Description:</strong><br>
        <%= event.getDescription() %>
    </p>

    <br>

    <p>
        <strong>Date:</strong>
        <%= event.getEventDate() %>
    </p>

    <p>
        <strong>Time:</strong>
        <%= event.getEventTime() %>
    </p>

    <p>
        <strong>Venue:</strong>
        <%= event.getVenue() %>
    </p>

    <p>
        <strong>Capacity:</strong>
        <%= event.getCapacity() %>
    </p>

    <p>
        <strong>Status:</strong>
        <%= event.getStatus() %>
    </p>

    <br>

    <a href="myRegistration.jsp?id=<%= event.getEventId() %>">
    <button class="btn-main">Register</button>
</a>

</div>

</body>
</html>