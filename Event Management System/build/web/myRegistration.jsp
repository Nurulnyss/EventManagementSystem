<%@page import="com.bean.EventBean"%>
<%@page import="com.model.eventDAO"%>
<%@page import="com.bean.RegistrationBean"%>
<%@page import="com.model.registrationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String error = null;

    int eventId = 0;
    EventBean event = null;

    try {
        eventId = Integer.parseInt(request.getParameter("id"));

        eventDAO eventDao = new eventDAO();
        event = eventDao.getEventById(eventId);

    } catch (Exception e) {
        e.printStackTrace();
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            RegistrationBean reg = new RegistrationBean();

            reg.setEventId(Integer.parseInt(request.getParameter("event_id")));
            reg.setUserName(request.getParameter("user_name"));
            reg.setUserEmail(request.getParameter("user_email"));
            reg.setUserPhone(request.getParameter("user_phone"));

            int age = 0;
            try {
                age = Integer.parseInt(request.getParameter("age"));
            } catch (Exception e) {
                age = 0;
            }

            reg.setAge(age);
            reg.setGender(request.getParameter("gender"));

            int participantCount = 1;
            try {
                participantCount = Integer.parseInt(request.getParameter("participant_count"));
            } catch (Exception e) {
                participantCount = 1;
            }

            reg.setParticipantCount(participantCount);
            reg.setNotes(request.getParameter("notes"));

            registrationDAO dao = new registrationDAO();

            boolean inserted = dao.insertRegistration(reg);

            if (inserted) {
%>
                <script>
                    alert("Registration successful. Your information has been received.");
                    window.location.href = "index.jsp";
                </script>
<%
                return;
            } else {
                error = "Registration failed. Please try again.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = e.getMessage();
        }
    }

    if (event == null) {
%>
        <script>
            alert("Event not found.");
            window.location.href = "index.jsp";
        </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Event</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="navbar">
    <div class="logo">
        <h2>Event Management System</h2>
    </div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="eventList.jsp">Events</a>
        <a href="adminLogin.jsp">Admin</a>
    </div>
</div>

<div class="register-shell">

    <div class="register-wrap">

        <div class="register-info">
            <span class="register-label">Event Registration</span>

            <h1><%= event.getTitle() %></h1>

            <p class="register-desc">
                Complete your details below to join this event.
            </p>

            <div class="event-summary">
                <div>
                    <small>Date</small>
                    <strong><%= event.getEventDate() %></strong>
                </div>

                <div>
                    <small>Time</small>
                    <strong><%= event.getEventTime() %></strong>
                </div>

                <div>
                    <small>Venue</small>
                    <strong><%= event.getVenue() %></strong>
                </div>

                <div>
                    <small>Capacity</small>
                    <strong><%= event.getCapacity() %></strong>
                </div>
            </div>
        </div>

        <div class="register-card">
            <h2>Participant Details</h2>

            <% if (error != null) { %>
                <div class="error-box">
                    <%= error %>
                </div>
            <% } %>

            <form action="myRegistration.jsp?id=<%= event.getEventId() %>" method="post">

                <input type="hidden" name="event_id" value="<%= event.getEventId() %>">

                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="user_name" placeholder="Enter your full name" required>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="user_email" placeholder="example@email.com" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="user_phone" placeholder="0123456789" required>
                    </div>

                    <div class="form-group">
                        <label>Age</label>
                        <input type="number" name="age" min="1" placeholder="Enter age" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender" required>
                            <option value="">Select gender</option>
                            <option value="Lelaki">Lelaki</option>
                            <option value="Perempuan">Perempuan</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Participant Count</label>
                        <input type="number" name="participant_count" value="1" min="1" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Notes</label>
                    <textarea name="notes" rows="4" placeholder="Any extra notes?"></textarea>
                </div>

                <button type="submit" class="full-btn">
                    Submit Registration
                </button>

            </form>
        </div>

    </div>

</div>

<div class="footer">
    <p>© 2026 Event System</p>
</div>

</body>
</html>