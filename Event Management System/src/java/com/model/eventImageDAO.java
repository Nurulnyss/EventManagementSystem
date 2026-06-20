package com.model;

import com.bean.EventImageBean;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class eventImageDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean insertImage(EventImageBean image) {

        boolean status = false;

        try {
            con = DBConnection.getConnection();

            String sql = "INSERT INTO event_images(event_title, image_name) VALUES (?,?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, image.getEventTitle());
            ps.setString(2, image.getImageName());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return status;
    }

    public List<EventImageBean> getAllImages() {

        List<EventImageBean> list = new ArrayList<>();

        try {
            con = DBConnection.getConnection();

            String sql = "SELECT * FROM event_images ORDER BY event_title ASC, image_id DESC";

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                EventImageBean image = new EventImageBean();

                image.setImageId(rs.getInt("image_id"));
                image.setEventTitle(rs.getString("event_title"));
                image.setImageName(rs.getString("image_name"));
                image.setUploadDate(rs.getString("upload_date"));

                list.add(image);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}