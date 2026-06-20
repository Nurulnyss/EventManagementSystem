package com.controller;

import com.bean.EventImageBean;
import com.model.eventImageDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class uploadEventImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String eventTitle = request.getParameter("event_title");

        if (eventTitle == null || eventTitle.trim().isEmpty()) {
            response.sendRedirect("eventList.jsp?error=no_title");
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            eventImageDAO dao = new eventImageDAO();

            Collection<Part> parts = request.getParts();

            for (Part part : parts) {

                if ("images".equals(part.getName()) && part.getSize() > 0) {

                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                    String newFileName = System.currentTimeMillis() + "_" + fileName;

                    part.write(uploadPath + File.separator + newFileName);

                    EventImageBean image = new EventImageBean();
                    image.setEventTitle(eventTitle);
                    image.setImageName(newFileName);

                    dao.insertImage(image);
                }
            }

            response.sendRedirect("eventList.jsp?success=uploaded");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("eventList.jsp?error=upload_failed");
        }
    }
}