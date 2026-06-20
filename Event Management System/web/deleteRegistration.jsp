<%@page import="com.model.registrationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("registration.jsp?error=no_id");
        return;
    }

    try {
        int id = Integer.parseInt(idParam);

        registrationDAO dao = new registrationDAO();

        boolean deleted = dao.deleteRegistration(id);

        if (deleted) {
            response.sendRedirect("registration.jsp?success=deleted");
            return;
        } else {
            response.sendRedirect("registration.jsp?error=delete_failed");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("registration.jsp?error=delete_error");
        return;
    }
%>