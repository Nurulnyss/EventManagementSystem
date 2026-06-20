<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bean.RegistrationBean"%>
<%@page import="com.model.registrationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    registrationDAO dao = new registrationDAO();
    List<RegistrationBean> registrations = dao.getAllRegistrations();

    Map<String, List<RegistrationBean>> groupedRegistrations = new LinkedHashMap<>();

    if (registrations != null) {
        for (RegistrationBean r : registrations) {
            String eventTitle = r.getEventTitle();

            if (eventTitle == null || eventTitle.trim().isEmpty()) {
                eventTitle = "Unknown Event";
            }

            if (!groupedRegistrations.containsKey(eventTitle)) {
                groupedRegistrations.put(eventTitle, new ArrayList<RegistrationBean>());
            }

            groupedRegistrations.get(eventTitle).add(r);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="navbar">
    <h3>EVENT SYSTEM ADMIN</h3>

    <div class="admin-menu">
        <a href="index.jsp">Home</a>
        <a href="createEvent.jsp">Create Event</a>
        <a href="manageEvent.jsp">Manage Event</a>
        <a href="registration.jsp">Registration</a>
    </div>
</div>

<div class="admin-page">

    <div class="admin-title">
        <h1>Event Registrations</h1>
        <p>Registrations are grouped by event.</p>
    </div>

    <%
        if (groupedRegistrations.isEmpty()) {
    %>

        <div class="empty-box">
            No registration found.
        </div>

    <%
        } else {
            for (Map.Entry<String, List<RegistrationBean>> entry : groupedRegistrations.entrySet()) {
                String eventTitle = entry.getKey();
                List<RegistrationBean> eventRegs = entry.getValue();
    %>

        <div class="event-registration-section">

            <div class="event-registration-header">
                <h2><%= eventTitle %></h2>
                <span><%= eventRegs.size() %> registration(s)</span>
            </div>

            <div class="table-box">

                <table class="table table-dark table-hover align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Age</th>
                            <th>Category</th>
                            <th>Gender</th>
                            <th>Participants</th>
                            <th>Notes</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                    <%
                        for (RegistrationBean r : eventRegs) {
                    %>

                        <tr>
                            <td><%= r.getRegistrationId() %></td>
                            <td><%= r.getUserName() %></td>
                            <td><%= r.getUserEmail() %></td>
                            <td><%= r.getUserPhone() %></td>
                            <td><%= r.getAge() %></td>
                            <td><%= r.getAgeCategory() %></td>
                            <td><%= r.getGender() %></td>
                            <td><%= r.getParticipantCount() %></td>
                            <td><%= r.getNotes() %></td>
                            <td><%= r.getRegistrationDate() %></td>
                            <td class="action-cell">
                                <a href="editRegistration.jsp?id=<%= r.getRegistrationId() %>" class="btn btn-primary btn-sm">
                                    Edit
                                </a>

                                <a href="deleteRegistration.jsp?id=<%= r.getRegistrationId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this registration?');">
                                    Delete
                                </a>
                            </td>
                        </tr>

                    <%
                        }
                    %>

                    </tbody>
                </table>

            </div>

        </div>

    <%
            }
        }
    %>

</div>

</body>
</html>