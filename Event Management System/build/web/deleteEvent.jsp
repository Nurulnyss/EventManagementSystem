<%@page import="com.model.eventDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().isEmpty()) {
        out.println("ERROR: ID is missing.");
        return;
    }

    try {
        int id = Integer.parseInt(idParam);

        eventDAO dao = new eventDAO();

        boolean deleted = dao.deleteEvent(id);

        if (deleted) {
            response.sendRedirect("manageEvent.jsp?success=deleted");
            return;
        } else {
            out.println("ERROR: Event not deleted. ID not found or database reject delete.");
            return;
        }

    } catch (Exception e) {
        out.println("<h3>DELETE ERROR</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
        return;
    }
%>