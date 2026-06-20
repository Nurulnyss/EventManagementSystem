<%@page import="java.util.List"%>
<%@page import="com.model.eventDAO"%>
<%@page import="com.bean.EventBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    eventDAO dao = new eventDAO();
    List<EventBean> events = dao.getPublishedEvents();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Event Management System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="navbar">
    <div class="logo">
        <h2>Events Management System</h2>
    </div>

    <div>
        <a href="index.jsp" class="active">Home</a>
        <a href="eventList.jsp">Events</a>
        
        <a href="adminLogin.jsp">Admin</a>
    </div>
</div>

<div class="hero">
    <div class="hero-content">
        <h1>Discover & Join Amazing Events</h1>
        <p>Explore exciting programmes, register easily, and stay connected with upcoming events.</p>

        <div class="hero-buttons">
            <button onclick="location.href='eventList.jsp'">Browse Events</button>
        </div>
    </div>
</div>

<h1 id="published-events" style="text-align:center; margin-top:0.5px;">Published Events</h1>

<div class="events">

<%
    if (events == null || events.isEmpty()) {
%>

    <p style="text-align:center;">No published events yet.</p>

<%
    } else {
        for (EventBean e : events) {
%>

    <div class="card">
        <h3><%= e.getTitle() %></h3>

        <p><%= e.getDescription() %></p>

        <p>
            <strong>Date:</strong>
            <%= e.getEventDate() %>
        </p>

        <p>
            <strong>Time:</strong>
            <%= e.getEventTime() %>
        </p>

        <p>
            <strong>Venue:</strong>
            <%= e.getVenue() %>
        </p>

        <p>
            <strong>Capacity:</strong>
            <%= e.getCapacity() %>
        </p>

        <a href="myRegistration.jsp?id=<%= e.getEventId() %>">
            <button>See Details</button>
        </a>
    </div>

<%
        }
    }
%>

</div>

<div style="text-align:center; padding:40px;">
    <h2>Our Features</h2>
    <br>
    <p>Easy Registration | Event Picture </p>
</div>

<div class="footer">
    <p>© 2026 Event System</p>
    
</div>

</body>
</html>