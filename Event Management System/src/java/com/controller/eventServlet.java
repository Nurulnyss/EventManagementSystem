package com.controller;

import com.bean.EventBean;
import com.model.eventDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class eventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        System.out.println("===== EVENT SERVLET START =====");
        System.out.println("ACTION = " + action);

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect("createEvent.jsp?error=no_action");
            return;
        }

        if ("create".equalsIgnoreCase(action)) {
            createEvent(request, response);
            return;
        }

        if ("publish".equalsIgnoreCase(action)) {
            publishEvent(request, response);
            return;
        }

        response.sendRedirect("manageEvent.jsp?error=unknown_action");
    }

    private void createEvent(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            EventBean event = new EventBean();

            event.setTitle(request.getParameter("title"));
            event.setDescription(request.getParameter("description"));
            event.setEventDate(request.getParameter("event_date"));
            event.setEventTime(request.getParameter("event_time"));
            event.setVenue(request.getParameter("venue"));
            event.setStatus("Pending");

            int capacity = 0;

            try {
                capacity = Integer.parseInt(request.getParameter("capacity"));
            } catch (Exception e) {
                capacity = 0;
            }

            event.setCapacity(capacity);

            eventDAO dao = new eventDAO();

            boolean inserted = dao.insertEvent(event);

            if (inserted) {
                response.sendRedirect("manageEvent.jsp");
            } else {
                request.setAttribute("error", "Event not saved.");
                request.getRequestDispatcher("createEvent.jsp").forward(request, response);
            }

        } catch (Exception ex) {
            ex.printStackTrace();

            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("createEvent.jsp").forward(request, response);
        }
    }

    private void publishEvent(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect("manageEvent.jsp?error=no_id");
                return;
            }

            int id = Integer.parseInt(idParam);

            System.out.println("PUBLISH EVENT ID = " + id);

            eventDAO dao = new eventDAO();

            boolean published = dao.publishEvent(id);

            System.out.println("PUBLISH RESULT = " + published);

            if (published) {
                response.sendRedirect("index.jsp");
                return;
            } else {
                response.sendRedirect("manageEvent.jsp?error=publish_failed");
                return;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("manageEvent.jsp?error=publish_error");
            return;
        }
    }
}