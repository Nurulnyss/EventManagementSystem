<%@page import="com.model.registrationDAO"%>
<%@page import="com.bean.RegistrationBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    RegistrationBean reg = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));

        registrationDAO dao = new registrationDAO();
        reg = dao.getRegistrationById(id);

    } catch (Exception e) {
        e.printStackTrace();
    }

    if (reg == null) {
%>
        <script>
            alert("Registration not found.");
            window.location.href = "registration.jsp";
        </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="admin-navbar">
    <h3>EVENT SYSTEM ADMIN</h3>

    <div class="admin-menu">
        <a href="index.jsp">Home</a>
        <a href="createEvent.jsp">Create Event</a>
        <a href="manageEvent.jsp">Manage Event</a>
        <a href="registration.jsp">Registration</a>
        <a href="adminLogout.jsp">Logout</a>
    </div>
</div>

<div class="registration-page">

    <div class="registration-card">

        <div class="registration-header">
            <span>Edit Registration</span>
            <h1>Participant Details</h1>
            <p>Update participant information below.</p>
        </div>

        <form action="updateRegistration.jsp" method="post">

            <input type="hidden" name="registration_id" value="<%= reg.getRegistrationId() %>">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="user_name" value="<%= reg.getUserName() %>" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="user_email" value="<%= reg.getUserEmail() %>" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="user_phone" value="<%= reg.getUserPhone() %>" required>
            </div>

            <div class="form-group">
                <label>Age</label>
                <input type="number" name="age" value="<%= reg.getAge() %>" min="1" required>
            </div>

            <div class="form-group">
                <label>Gender</label>
                <select name="gender" required>
                    <option value="Lelaki" <%= "Lelaki".equalsIgnoreCase(reg.getGender()) ? "selected" : "" %>>
                        Lelaki
                    </option>
                    <option value="Perempuan" <%= "Perempuan".equalsIgnoreCase(reg.getGender()) ? "selected" : "" %>>
                        Perempuan
                    </option>
                </select>
            </div>

            <div class="form-group">
                <label>Participant Count</label>
                <input type="number" name="participant_count" value="<%= reg.getParticipantCount() %>" min="1" required>
            </div>

            <div class="form-group">
                <label>Notes</label>
                <textarea name="notes" rows="4"><%= reg.getNotes() %></textarea>
            </div>

            <button type="submit" class="btn-main full-btn">
                Update Registration
            </button>

            <a href="registration.jsp" class="back-link">
                Back to registration list
            </a>

        </form>

    </div>

</div>

</body>
</html>