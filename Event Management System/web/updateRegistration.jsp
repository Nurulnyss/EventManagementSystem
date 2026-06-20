<%@page import="com.bean.RegistrationBean"%>
<%@page import="com.model.registrationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (adminLoggedIn == null || !adminLoggedIn) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    try {
        int registrationId = Integer.parseInt(request.getParameter("registration_id"));

        String userName = request.getParameter("user_name");
        String userEmail = request.getParameter("user_email");
        String userPhone = request.getParameter("user_phone");
        String gender = request.getParameter("gender");
        String notes = request.getParameter("notes");

        int age = Integer.parseInt(request.getParameter("age"));
        int participantCount = Integer.parseInt(request.getParameter("participant_count"));

        RegistrationBean reg = new RegistrationBean();

        reg.setRegistrationId(registrationId);
        reg.setUserName(userName);
        reg.setUserEmail(userEmail);
        reg.setUserPhone(userPhone);
        reg.setAge(age);
        reg.setGender(gender);
        reg.setParticipantCount(participantCount);
        reg.setNotes(notes);

        registrationDAO dao = new registrationDAO();

        boolean updated = dao.updateRegistration(reg);

        if (updated) {
            response.sendRedirect("registration.jsp?success=updated");
            return;
        } else {
            response.sendRedirect("registration.jsp?error=update_failed");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("registration.jsp?error=update_error");
        return;
    }
%>