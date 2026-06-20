<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Event</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">

    <style>
        .card{
            background:#111;
            color:white;
            border:1px solid #333;
        }

        .form-control{
            background:#222;
            color:white;
            border:none;
        }

        .form-control:focus{
            border:1px solid #FFD700;
            box-shadow:none;
        }

        .btn-success{
            background:#FFD700;
            border:none;
            color:black;
            font-weight:bold;
        }

        .btn-success:hover{
            background:#e6c200;
        }
    </style>
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

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header">
            <h3>Create Event</h3>
        </div>

        <div class="card-body">
            <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <div class="alert alert-danger">
        <strong>Error:</strong> <%= error %>
    </div>
<%
    }
%>

            <form action="eventServlet" method="post">

                <input type="hidden" name="action" value="create">

                <div class="mb-3">
                    <label>Title</label>
                    <input type="text" name="title" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label>Date</label>
                    <input type="date" name="event_date" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Time</label>
                    <input type="time" name="event_time" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Venue</label>
                    <input type="text" name="venue" class="form-control">
                </div>

                <div class="mb-3">
                    <label>Capacity</label>
                    <input type="number" name="capacity" class="form-control" required>
                </div>

                <input type="hidden" name="status" value="Pending">

                <button type="submit" class="btn btn-success w-100">
                    Save Event
                </button>

            </form>

        </div>
    </div>
</div>

</body>
</html>