<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bean.EventImageBean"%>
<%@page import="com.model.eventImageDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    eventImageDAO dao = new eventImageDAO();
    List<EventImageBean> images = dao.getAllImages();

    Map<String, List<EventImageBean>> albumMap = new LinkedHashMap<>();

    if (images != null) {
        for (EventImageBean img : images) {
            String title = img.getEventTitle();

            if (!albumMap.containsKey(title)) {
                albumMap.put(title, new ArrayList<EventImageBean>());
            }

            albumMap.get(title).add(img);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Album</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<div class="navbar">
    <div class="logo">
        <h2>Events Management System</h2>
    </div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="eventList.jsp" class="active">Events</a>
        
        <a href="adminLogin.jsp">Admin</a>
    </div>
</div>

<div class="album-page">

    <div class="album-title">
        <h1>Event Album</h1>
        <p>Upload and view event photos by event title.</p>
    </div>

    <div class="album-upload-card">
        <h2>Upload Event Photos</h2>

        <form action="uploadEventImageServlet" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Event Title</label>
                <input type="text" name="event_title" placeholder="Enter event title" required>
            </div>

            <div class="form-group">
                <label>Upload Images</label>
                <input type="file" name="images" accept="image/*" multiple required>
            </div>

            <button type="submit" class="full-btn">
                Upload Photos
            </button>

        </form>
    </div>

    <%
        if (albumMap.isEmpty()) {
    %>

        <div class="empty-box">
            No event photos uploaded yet.
        </div>

    <%
        } else {
            for (Map.Entry<String, List<EventImageBean>> entry : albumMap.entrySet()) {
    %>

        <div class="album-section">

            <h2><%= entry.getKey() %></h2>

            <div class="album-grid">

                <%
                    for (EventImageBean img : entry.getValue()) {
                %>

                    <div class="album-card">
                        <img src="uploads/<%= img.getImageName() %>" alt="<%= img.getEventTitle() %>">
                    </div>

                <%
                    }
                %>

            </div>

        </div>

    <%
            }
        }
    %>

</div>
<div class="footer">
    <p>© 2026 Event System</p>
    
</div>
</body>
</html>