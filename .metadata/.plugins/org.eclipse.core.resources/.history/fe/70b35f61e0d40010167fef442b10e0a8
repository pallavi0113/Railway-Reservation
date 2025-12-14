package com.railway.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.railway.model.Train;
import com.railway.util.DBConnection; 

public class TrainDAO {
	public List<Train> getAllTrains() {
        List<Train> trains = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM trains ORDER BY train_id";
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                Train train = extractTrainFromResultSet(rs);
                trains.add(train);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return trains;
    }
	
	public List<Train> searchTrains(String source, String destination) {
        List<Train> trains = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM trains WHERE UPPER(source_station) LIKE UPPER(?) " +
                        "AND UPPER(destination_station) LIKE UPPER(?) AND available_seats > 0";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + source + "%");
            pstmt.setString(2, "%" + destination + "%");
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Train train = extractTrainFromResultSet(rs);
                trains.add(train);
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
        return trains;
    }
	
	public Train getTrainById(int trainId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM trains WHERE train_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, trainId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractTrainFromResultSet(rs);
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
        return null;
    }
	
	public boolean updateAvailableSeats(int trainId, int seatsToBook) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE trains SET available_seats = available_seats - ? " +
                        "WHERE train_id = ? AND available_seats >= ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, seatsToBook);
            pstmt.setInt(2, trainId);
            pstmt.setInt(3, seatsToBook);
            
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
	
	private Train extractTrainFromResultSet(ResultSet rs) throws SQLException {
        Train train = new Train();
        train.setTrainId(rs.getInt("train_id"));
        train.setTrainName(rs.getString("train_name"));
        train.setTrainNumber(rs.getString("train_number"));
        train.setSourceStation(rs.getString("source_station"));
        train.setDestinationStation(rs.getString("destination_station"));
        train.setDepartureTime(rs.getString("departure_time"));
        train.setArrivalTime(rs.getString("arrival_time"));
        train.setTotalSeats(rs.getInt("total_seats"));
        train.setAvailableSeats(rs.getInt("available_seats"));
        train.setFare(rs.getDouble("fare"));
        return train;
    }
	
}
