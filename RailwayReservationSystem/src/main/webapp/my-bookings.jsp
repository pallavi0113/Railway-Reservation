<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.railway.dao.ReservationDAO, com.railway.model.Reservation, com.railway.model.User" %>
<%
    // 1. Security Check: Is user logged in?
    User user = (User) session.getAttribute("user");
    if(user == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    // 2. Fetch Data: Get bookings for this specific user
    ReservationDAO dao = new ReservationDAO();
    List<Reservation> myBookings = dao.getUserReservations(user.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - Railway System</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding: 20px; }
        .container { max-width: 900px; margin: 0 auto; }
        
        /* Header Style */
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header h2 { color: #2d3748; margin: 0; }
        .btn-back { text-decoration: none; color: #667eea; font-weight: bold; padding: 8px 15px; border: 1px solid #667eea; border-radius: 5px; transition: 0.3s; }
        .btn-back:hover { background: #667eea; color: white; }

        /* Ticket Card Style */
        .ticket-card { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-left: 5px solid #667eea; transition: 0.3s; }
        .ticket-card:hover { transform: translateY(-3px); box-shadow: 0 10px 15px rgba(0,0,0,0.1); }
        
        .ticket-info h3 { margin: 0 0 5px 0; color: #2d3748; }
        .ticket-route { color: #718096; font-size: 14px; margin-bottom: 10px; }
        .ticket-details { font-size: 14px; color: #4a5568; display: flex; gap: 20px; }
        .ticket-details span { background: #edf2f7; padding: 5px 10px; border-radius: 5px; }

        .ticket-status { text-align: right; }
        .price { font-size: 20px; font-weight: bold; color: #2d3748; }
        .status-badge { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; margin-top: 5px; }
        
        .status-confirmed { background: #c6f6d5; color: #276749; }
        .status-cancelled { background: #fed7d7; color: #9b2c2c; }
        
        .no-bookings { text-align: center; margin-top: 50px; color: #a0aec0; }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h2>🎟️ My Bookings</h2>
            <a href="user-dashboard.jsp" class="btn-back">← Back to Dashboard</a>
        </div>

        <% 
        if (myBookings != null && !myBookings.isEmpty()) {
            for (Reservation r : myBookings) {
        %>
            <div class="ticket-card">
                <div class="ticket-info">
                    <h3><%= r.getTrainName() %> (<%= r.getTrainNumber() %>)</h3>
                    
                    <div class="ticket-route">
                        <%= r.getSourceStation() %> ➝ <%= r.getDestinationStation() %>
                    </div>

                    <div class="ticket-details">
                        <span>📅 <%= r.getJourneyDate() %></span>
                        <span>👤 <%= r.getPassengerName() %></span>
                        <span>💺 Seats: <%= r.getSeatsBooked() %></span>
                    </div>
                </div>

                <div class="ticket-status">
			    <div class="price">₹<%= r.getTotalFare() %></div>
			
			    <% 
			        // 🧠 LOGIC: Check Date vs Today
			        java.util.Date today = new java.util.Date();
			        boolean isPastJourney = r.getJourneyDate().before(today);
			        boolean isCancelled = "CANCELLED".equalsIgnoreCase(r.getBookingStatus());
			    %>
			
			    <% if (isCancelled) { %>
			        <span class="status-badge status-cancelled">CANCELLED</span>
			    
			    <% } else if (isPastJourney) { %>
			        <span class="status-badge" style="background:#e2e8f0; color:#4a5568;">JOURNEY COMPLETED</span>
			        <br>
			        <span style="font-size:10px; color:grey;">(History)</span>
			
			    <% } else { %>
			        <span class="status-badge status-confirmed">CONFIRMED</span>
			        <br><br>
			        
			        <a href="view-ticket.jsp?id=<%= r.getReservationId() %>" target="_blank" 
			           style="color: blue; text-decoration: underline; font-size: 13px; margin-right: 10px;">
			           ⬇ Download
			        </a>
			
			        <a href="CancelServlet?id=<%= r.getReservationId() %>" 
			           onclick="return confirm('Are you sure you want to cancel? Refund will be processed.')"
			           style="background: #e53e3e; color: white; padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 12px;">
			           ✖ Cancel
			        </a>
			    <% } %>
			    
			    <br><br>
			    <small style="color: #718096;">ID: #<%= r.getReservationId() %></small>
			</div>
            </div>
        <% 
            }
        } else { 
        %>
            <div class="no-bookings">
                <h3>You haven't booked any tickets yet.</h3>
                <p>Go to the dashboard to find trains!</p>
                <a href="search-trains.jsp" class="btn-back">Book a Ticket</a>
            </div>
        <% } %>

    </div>

</body>
</html>