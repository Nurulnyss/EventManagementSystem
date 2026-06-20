package com.model;

import com.bean.EventBean;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class eventDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // =========================
    // GET ALL EVENTS (ADMIN)
    // =========================
    public List<EventBean> getAllEvents() {

        List<EventBean> eventList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM events ORDER BY event_id DESC";

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                EventBean event = new EventBean();

                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setVenue(rs.getString("venue"));
                event.setCapacity(rs.getInt("capacity"));
                event.setStatus(rs.getString("status"));

                eventList.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return eventList;
    }

    // =========================
    // GET PUBLISHED EVENTS (USER)
    // =========================
    public List<EventBean> getPublishedEvents() {

        List<EventBean> eventList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM events WHERE status='Published'";

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                EventBean event = new EventBean();

                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setVenue(rs.getString("venue"));
                event.setCapacity(rs.getInt("capacity"));
                event.setStatus(rs.getString("status"));

                eventList.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return eventList;
    }

    // =========================
    // GET EVENT BY ID
    // =========================
    public EventBean getEventById(int id) {

        EventBean event = null;

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM events WHERE event_id=?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {

                event = new EventBean();

                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setVenue(rs.getString("venue"));
                event.setCapacity(rs.getInt("capacity"));
                event.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return event;
    }

    // =========================
    // INSERT EVENT
    // =========================
    public boolean insertEvent(EventBean event) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "INSERT INTO events(title, description, event_date, event_time, venue, capacity, status) VALUES (?,?,?,?,?,?,?)";

            ps = con.prepareStatement(sql);

            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getEventDate());
            ps.setString(4, event.getEventTime());
            ps.setString(5, event.getVenue());
            ps.setInt(6, event.getCapacity());
            ps.setString(7, event.getStatus());

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

    public boolean publishEvent(int id) {

    boolean status = false;

    try {
        con = DBConnection.getConnection();

        String sql = "UPDATE events SET status=? WHERE event_id=?";

        ps = con.prepareStatement(sql);
        ps.setString(1, "Published");
        ps.setInt(2, id);

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

    public boolean updateEvent(EventBean event) {

    boolean status = false;

    try {
        con = DBConnection.getConnection();

        String sql = "UPDATE events SET title=?, description=?, event_date=?, event_time=?, venue=?, capacity=?, status=? WHERE event_id=?";

        ps = con.prepareStatement(sql);

        ps.setString(1, event.getTitle());
        ps.setString(2, event.getDescription());
        ps.setString(3, event.getEventDate());
        ps.setString(4, event.getEventTime());
        ps.setString(5, event.getVenue());
        ps.setInt(6, event.getCapacity());
        ps.setString(7, event.getStatus());
        ps.setInt(8, event.getEventId());

        int row = ps.executeUpdate();

        if (row > 0) {
            status = true;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return status;
}
    public boolean deleteEvent(int id) {

    boolean status = false;

    try {
        con = DBConnection.getConnection();

        String sql = "DELETE FROM events WHERE event_id=?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, id);

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
}