<%@page import="com.model.eventDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("manageEvent.jsp?error=no_id");
        return;
    }

    try {
        int id = Integer.parseInt(idParam);

        eventDAO dao = new eventDAO();

        boolean published = dao.publishEvent(id);

        if (published) {
            response.sendRedirect("manageEvent.jsp?success=published");
            return;
        } else {
            response.sendRedirect("manageEvent.jsp?error=publish_failed");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manageEvent.jsp?error=publish_error");
        return;
    }
%>