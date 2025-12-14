package com.railway.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.railway.model.Reservation;
import com.railway.util.DBConnection;

public class ReservationDAO {
    
    // 1. Book a Ticket
    public boolean bookTicket(Reservation reservation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO reservations (reservation_id, user_id, train_id, " +
                         "passenger_name, age, gender, journey_date, seats_booked, total_fare, booking_status) " +
                         "VALUES (reservation_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reservation.getUserId());
            pstmt.setInt(2, reservation.getTrainId());
            pstmt.setString(3, reservation.getPassengerName());
            pstmt.setInt(4, reservation.getAge());
            pstmt.setString(5, reservation.getGender());
            pstmt.setDate(6, new java.sql.Date(reservation.getJourneyDate().getTime()));
            pstmt.setInt(7, reservation.getSeatsBooked());
            pstmt.setDouble(8, reservation.getTotalFare());
            pstmt.setString(9, reservation.getBookingStatus());
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 2. Get User History (Used in my-bookings.jsp)
    public List<Reservation> getUserReservations(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            // JOIN query to get Train Names along with Booking Info
            String sql = "SELECT r.*, t.train_name, t.train_number, t.source_station, " +
                         "t.destination_station FROM reservations r " +
                         "JOIN trains t ON r.train_id = t.train_id " +
                         "WHERE r.user_id = ? ORDER BY r.booking_date DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservationId(rs.getInt("reservation_id"));
                res.setUserId(rs.getInt("user_id"));
                res.setTrainId(rs.getInt("train_id"));
                res.setPassengerName(rs.getString("passenger_name"));
                res.setAge(rs.getInt("age"));
                res.setGender(rs.getString("gender"));
                res.setJourneyDate(rs.getDate("journey_date"));
                res.setSeatsBooked(rs.getInt("seats_booked"));
                res.setTotalFare(rs.getDouble("total_fare"));
                res.setBookingStatus(rs.getString("booking_status"));
                res.setBookingDate(rs.getDate("booking_date"));
                
                // Set extra train details for display
                res.setTrainName(rs.getString("train_name"));
                res.setTrainNumber(rs.getString("train_number"));
                res.setSourceStation(rs.getString("source_station"));
                res.setDestinationStation(rs.getString("destination_station"));
                
                reservations.add(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reservations;
    }
    
 // 3. Cancel Ticket (The "Smart" Version)
    public boolean cancelTicket(int reservationId) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // ⚠️ Start Transaction

            // Step 1: Find out which train and how many seats were booked
            String getSql = "SELECT train_id, seats_booked FROM reservations WHERE reservation_id = ?";
            ps1 = conn.prepareStatement(getSql);
            ps1.setInt(1, reservationId);
            rs = ps1.executeQuery();
            
            if (rs.next()) {
                int trainId = rs.getInt("train_id");
                int seatsToReturn = rs.getInt("seats_booked");

                // Step 2: Mark the reservation as CANCELLED
                String updateResSql = "UPDATE reservations SET booking_status = 'CANCELLED' WHERE reservation_id = ?";
                ps2 = conn.prepareStatement(updateResSql);
                ps2.setInt(1, reservationId);
                ps2.executeUpdate();

                // Step 3: Increase the available seats in the train
                String updateTrainSql = "UPDATE trains SET available_seats = available_seats + ? WHERE train_id = ?";
                ps3 = conn.prepareStatement(updateTrainSql);
                ps3.setInt(1, seatsToReturn);
                ps3.setInt(2, trainId);
                ps3.executeUpdate();

                conn.commit(); // ✅ Save Everything
                return true;
            } else {
                return false; // Reservation ID not found
            }

        } catch (SQLException e) {
            try { if(conn!=null) conn.rollback(); } catch(Exception ex){} // Undo if error
            e.printStackTrace();
            return false;
        } finally {
            try { 
                if(rs!=null)rs.close(); 
                if(ps1!=null)ps1.close(); 
                if(ps2!=null)ps2.close(); 
                if(ps3!=null)ps3.close(); 
                if(conn!=null)conn.close(); 
            } catch(Exception e){}
        }
    }
    
 // 4. ADMIN: Get ALL Reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            // Order by newest bookings first
            String sql = "SELECT r.*, t.train_name, t.train_number, t.source_station, t.destination_station " +
                         "FROM reservations r " +
                         "JOIN trains t ON r.train_id = t.train_id " +
                         "ORDER BY r.booking_date DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservationId(rs.getInt("reservation_id"));
                res.setUserId(rs.getInt("user_id")); // Admin needs to see WHO booked it
                res.setPassengerName(rs.getString("passenger_name"));
                res.setJourneyDate(rs.getDate("journey_date"));
                res.setSeatsBooked(rs.getInt("seats_booked"));
                res.setTotalFare(rs.getDouble("total_fare"));
                res.setBookingStatus(rs.getString("booking_status"));
                res.setBookingDate(rs.getDate("booking_date"));
                
                // Train Details
                res.setTrainName(rs.getString("train_name"));
                res.setTrainNumber(rs.getString("train_number"));
                res.setSourceStation(rs.getString("source_station"));
                res.setDestinationStation(rs.getString("destination_station"));
                
                list.add(res);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { try { if(conn!=null)conn.close(); } catch(Exception e){} }
        return list;
    }
}