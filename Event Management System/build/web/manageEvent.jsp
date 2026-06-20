<%@page import="java.util.List"%>
<%@page import="com.model.eventDAO"%>
<%@page import="com.bean.EventBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    eventDAO dao = new eventDAO();
    List<EventBean> events = dao.getAllEvents();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Event</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<style>
        .title h2{
            color:#FFD700;
        }

        .container-box{
            width:95%;
            margin:auto;
            margin-top:30px;
        }

        table{
            background:#111 !important;
            color:white !important;
        }

        thead{
            background:#222;
            color:#FFD700;
        }

        .btn-gold{
            background:#FFD700;
            color:black;
            border:none;
            padding:5px 10px;
            border-radius:5px;
            font-weight:bold;
        }

        .btn-gold:hover{
            background:#e6c200;
        }

        .btn-blue{
            background:#0d6efd;
            color:white;
            border:none;
            padding:5px 10px;
            border-radius:5px;
        }

        .btn-red{
            background:#dc3545;
            color:white;
            border:none;
            padding:5px 10px;
            border-radius:5px;
        }

        .pending{
            color:orange;
            font-weight:bold;
        }

        .published{
            color:lime;
            font-weight:bold;
        }

</style>
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

<div class="title">
    <h2>MANAGE EVENTS</h2>
    <p>All Events Created By Admin</p>
</div>

<div class="container-box">

    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Date</th>
                <th>Time</th>
                <th>Venue</th>
                <th>Capacity</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

        <%
            if (events != null && !events.isEmpty()) {
                for (EventBean e : events) {
        %>

        <tr>
            <td><%= e.getEventId() %></td>
            <td><%= e.getTitle() %></td>
            <td><%= e.getEventDate() %></td>
            <td><%= e.getEventTime() %></td>
            <td><%= e.getVenue() %></td>
            <td><%= e.getCapacity() %></td>

            <td>
                <% if ("Published".equalsIgnoreCase(e.getStatus())) { %>
                    <span class="badge bg-success">
                        <%= e.getStatus() %>
                    </span>
                <% } else { %>
                    <span class="badge bg-warning text-dark">
                        <%= e.getStatus() %>
                    </span>
                <% } %>
            </td>

            <td>
    <% if (!"Published".equalsIgnoreCase(e.getStatus())) { %>

        <form action="eventServlet" method="post" class="publish-form">
    <input type="hidden" name="action" value="publish">
    <input type="hidden" name="id" value="<%= e.getEventId() %>">

    <button type="submit" class="btn btn-warning btn-sm">
        Publish
    </button>
</form>

    <% } else { %>

        <span class="btn btn-success btn-sm disabled">
            Published
        </span>

    <% } %>

    <a href="editEvent.jsp?id=<%= e.getEventId() %>" class="btn btn-primary btn-sm">
        Edit
    </a>

    <a href="deleteEvent.jsp?id=<%= e.getEventId() %>"
   class="btn btn-danger btn-sm"
   onclick="return confirm('Are you sure you want to delete this event?');">
    Delete
</a>
</td>
        </tr>

        <%
                }
            } else {
        %>

        <tr>
            <td colspan="8" class="text-center">
                No Event Found
            </td>
        </tr>

        <%
            }
        %>

        </tbody>
    </table>

</div>

</body>
</html>