<%@page import="com.bean.EventBean"%>
<%@page import="com.model.eventDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        int id = Integer.parseInt(request.getParameter("id"));

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String eventDate = request.getParameter("event_date");
        String eventTime = request.getParameter("event_time");
        String venue = request.getParameter("venue");
        String status = request.getParameter("status");

        int capacity = 0;

        try {
            capacity = Integer.parseInt(request.getParameter("capacity"));
        } catch (Exception e) {
            capacity = 0;
        }

        EventBean event = new EventBean();

        event.setEventId(id);
        event.setTitle(title);
        event.setDescription(description);
        event.setEventDate(eventDate);
        event.setEventTime(eventTime);
        event.setVenue(venue);
        event.setCapacity(capacity);
        event.setStatus(status);

        eventDAO dao = new eventDAO();

        boolean updated = dao.updateEvent(event);

        if (updated) {
            response.sendRedirect("manageEvent.jsp?success=updated");
        } else {
            response.sendRedirect("manageEvent.jsp?error=update_failed");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manageEvent.jsp?error=update_error");
    }
%>