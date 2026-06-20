<%@page import="com.model.eventDAO"%>
<%@page import="com.bean.EventBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int id = 0;
    EventBean event = null;

    try {
        id = Integer.parseInt(request.getParameter("id"));

        eventDAO dao = new eventDAO();
        event = dao.getEventById(id);

    } catch (Exception e) {
        e.printStackTrace();
    }

    if (event == null) {
%>
        <script>
            alert("Event not found.");
            window.location.href = "manageEvent.jsp";
        </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body style="background:#000; color:white;">
<div class="navbar">
    <h3>EVENT SYSTEM ADMIN</h3>

    <div>
        <a href="index.jsp">Home</a>
        <a href="createEvent.jsp">Create Event</a>
        <a href="manageEvent.jsp">Manage Event</a>
        <a href="registration.jsp">Registration</a>
        
    </div>
</div>
<div class="container mt-5">

    <div class="card bg-dark text-white">

        <div class="card-header">
            <h3>Edit Event</h3>
        </div>

        <div class="card-body">

            <form action="updateEvent.jsp" method="post">

                <input type="hidden" name="id" value="<%= event.getEventId() %>">

                <div class="mb-3">
                    <label>Title</label>
                    <input type="text" name="title" class="form-control"
                           value="<%= event.getTitle() %>" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control"><%= event.getDescription() %></textarea>
                </div>

                <div class="mb-3">
                    <label>Date</label>
                    <input type="date" name="event_date" class="form-control"
                           value="<%= event.getEventDate() %>" required>
                </div>

                <div class="mb-3">
                    <label>Time</label>
                    <input type="time" name="event_time" class="form-control"
                           value="<%= event.getEventTime() %>" required>
                </div>

                <div class="mb-3">
                    <label>Venue</label>
                    <input type="text" name="venue" class="form-control"
                           value="<%= event.getVenue() %>">
                </div>

                <div class="mb-3">
                    <label>Capacity</label>
                    <input type="number" name="capacity" class="form-control"
                           value="<%= event.getCapacity() %>" required>
                </div>

                <div class="mb-3">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="Pending" <%= "Pending".equalsIgnoreCase(event.getStatus()) ? "selected" : "" %>>
                            Pending
                        </option>

                        <option value="Published" <%= "Published".equalsIgnoreCase(event.getStatus()) ? "selected" : "" %>>
                            Published
                        </option>
                    </select>
                </div>

                <button type="submit" class="btn btn-warning w-100">
                    Update Event
                </button>

                <a href="manageEvent.jsp" class="btn btn-secondary w-100 mt-2">
                    Back
                </a>

            </form>

        </div>
    </div>
</div>

</body>
</html>