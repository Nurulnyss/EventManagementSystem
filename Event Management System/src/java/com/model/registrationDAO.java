package com.model;

import com.bean.RegistrationBean;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class registrationDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean insertRegistration(RegistrationBean reg) {

        boolean status = false;

        try {
            con = DBConnection.getConnection();

            String sql = "INSERT INTO registrations(event_id, user_name, user_email, user_phone, age, gender, participant_count, notes) VALUES (?,?,?,?,?,?,?,?)";

            ps = con.prepareStatement(sql);
            ps.setInt(1, reg.getEventId());
            ps.setString(2, reg.getUserName());
            ps.setString(3, reg.getUserEmail());
            ps.setString(4, reg.getUserPhone());
            ps.setInt(5, reg.getAge());
            ps.setString(6, reg.getGender());
            ps.setInt(7, reg.getParticipantCount());
            ps.setString(8, reg.getNotes());

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

    public List<RegistrationBean> getAllRegistrations() {

        List<RegistrationBean> list = new ArrayList<>();

        try {
            con = DBConnection.getConnection();

            String sql = "SELECT r.*, e.title "
        + "FROM registrations r "
        + "INNER JOIN events e ON r.event_id = e.event_id "
        + "ORDER BY e.title ASC, r.registration_id DESC";

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                RegistrationBean reg = new RegistrationBean();

                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setEventId(rs.getInt("event_id"));
                reg.setUserName(rs.getString("user_name"));
                reg.setUserEmail(rs.getString("user_email"));
                reg.setUserPhone(rs.getString("user_phone"));
                reg.setAge(rs.getInt("age"));
                reg.setGender(rs.getString("gender"));
                reg.setParticipantCount(rs.getInt("participant_count"));
                reg.setNotes(rs.getString("notes"));
                reg.setRegistrationDate(rs.getString("registration_date"));
                reg.setEventTitle(rs.getString("title"));

                list.add(reg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public RegistrationBean getRegistrationById(int id) {

    RegistrationBean reg = null;

    try {
        con = DBConnection.getConnection();

        String sql = "SELECT * FROM registrations WHERE registration_id=?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, id);

        rs = ps.executeQuery();

        if (rs.next()) {
            reg = new RegistrationBean();

            reg.setRegistrationId(rs.getInt("registration_id"));
            reg.setEventId(rs.getInt("event_id"));
            reg.setUserName(rs.getString("user_name"));
            reg.setUserEmail(rs.getString("user_email"));
            reg.setUserPhone(rs.getString("user_phone"));
            reg.setAge(rs.getInt("age"));
            reg.setGender(rs.getString("gender"));
            reg.setParticipantCount(rs.getInt("participant_count"));
            reg.setNotes(rs.getString("notes"));
            reg.setRegistrationDate(rs.getString("registration_date"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return reg;
}

public boolean updateRegistration(RegistrationBean reg) {

    boolean status = false;

    try {
        con = DBConnection.getConnection();

        String sql = "UPDATE registrations SET user_name=?, user_email=?, user_phone=?, age=?, gender=?, participant_count=?, notes=? WHERE registration_id=?";

        ps = con.prepareStatement(sql);
        ps.setString(1, reg.getUserName());
        ps.setString(2, reg.getUserEmail());
        ps.setString(3, reg.getUserPhone());
        ps.setInt(4, reg.getAge());
        ps.setString(5, reg.getGender());
        ps.setInt(6, reg.getParticipantCount());
        ps.setString(7, reg.getNotes());
        ps.setInt(8, reg.getRegistrationId());

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

public boolean deleteRegistration(int id) {

    boolean status = false;

    try {
        con = DBConnection.getConnection();

        String sql = "DELETE FROM registrations WHERE registration_id=?";

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