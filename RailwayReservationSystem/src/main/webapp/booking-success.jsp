<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.Reservation" %>
<%
    // Get the reservation object sent by the Servlet
    Reservation res = (Reservation) request.getAttribute("reservation");
    
    // Safety check: If someone tries to open this page directly without booking, send them home
    if(res == null) { 
        response.sendRedirect("user-dashboard.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmed - Railway System</title>
    <style>
        body { font-family: 'Courier New', Courier, monospace; background: #e2e8f0; display: flex; justify-content: center; padding-top: 50px; }
        .ticket { background: white; width: 600px; padding: 20px; border-left: 10px solid #48bb78; border-right: 10px dotted #48bb78; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .header { text-align: center; border-bottom: 2px dashed #cbd5e0; padding-bottom: 10px; margin-bottom: 20px; }
        .header h2 { color: #2d3748; margin: 0; }
        .success-msg { color: #48bb78; font-weight: bold; font-size: 18px; }
        .row { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .label { color: #718096; font-size: 14px; font-weight: bold; }
        .value { color: #2d3748; font-size: 16px; font-weight: bold; }
        .total-price { background: #f0fff4; padding: 15px; text-align: center; border: 2px dashed #48bb78; font-size: 24px; font-weight: bold; color: #2f855a; margin-top: 20px; }
        .btn-home { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: #4299e1; font-weight: bold; font-family: Arial, sans-serif; padding: 10px; border: 1px solid #4299e1; border-radius: 5px; }
        .btn-home:hover { background: #ebf8ff; }
    </style>
</head>
<body>

    <div class="ticket">
        <div class="header">
            <h2>🚂 RAILWAY TICKET</h2>
            <p class="success-msg">✅ Booking Confirmed</p>
        </div>

        <div class="row">
            <div>
                <span class="label">PASSENGER NAME</span><br>
                <span class="value"><%= res.getPassengerName() %></span>
            </div>
            <div>
                <span class="label">AGE / GENDER</span><br>
                <span class="value"><%= res.getAge() %> / <%= res.getGender() %></span>
            </div>
        </div>

        <div class="row">
            <div>
                <span class="label">JOURNEY DATE</span><br>
                <span class="value"><%= res.getJourneyDate() %></span>
            </div>
            <div>
                <span class="label">SEATS BOOKED</span><br>
                <span class="value"><%= res.getSeatsBooked() %></span>
            </div>
        </div>
        
        <div class="row">
             <div>
                <span class="label">STATUS</span><br>
                <span class="value" style="color: green;">CONFIRMED</span>
            </div>
        </div>

        <div class="total-price">
            TOTAL PAID: ₹<%= res.getTotalFare() %>
        </div>

        <a href="user-dashboard.jsp" class="btn-home">🏠 Return to Dashboard</a>
    </div>

</body>
</html>