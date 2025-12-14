<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.dao.ReservationDAO, com.railway.model.Reservation, com.railway.model.User, java.util.List" %>
<%
    // 1. Security Check
    User user = (User) session.getAttribute("user");
    if(user == null) { response.sendRedirect("login.jsp"); return; }

    // 2. Get the Reservation ID from the URL link (e.g. view-ticket.jsp?id=5)
    String idStr = request.getParameter("id");
    if(idStr == null) { response.sendRedirect("my-bookings.jsp"); return; }
    
    int resId = Integer.parseInt(idStr);

    // 3. Fetch the specific reservation from Database
    ReservationDAO dao = new ReservationDAO();
    // We reuse the existing method to get all bookings, then find the specific one
    // (In a real app, you would make a getReservationById() method in DAO, but this works for now)
    List<Reservation> list = dao.getUserReservations(user.getUserId());
    
    Reservation res = null;
    for(Reservation r : list) {
        if(r.getReservationId() == resId) {
            res = r;
            break;
        }
    }

    if(res == null) { 
        out.println("<h3>Ticket not found or access denied.</h3>"); 
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Ticket #<%= res.getReservationId() %></title>
    <style>
        /* Same Styling as Booking Success */
        body { font-family: 'Courier New', Courier, monospace; background: white; display: flex; flex-direction: column; align-items: center; padding-top: 50px; }
        .ticket { background: white; width: 600px; padding: 20px; border: 2px solid #2d3748; box-shadow: none; }
        .header { text-align: center; border-bottom: 2px dashed #000; padding-bottom: 10px; margin-bottom: 20px; }
        .header h2 { color: #000; margin: 0; }
        .success-msg { color: #000; font-weight: bold; font-size: 18px; }
        .row { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .label { color: #555; font-size: 14px; font-weight: bold; }
        .value { color: #000; font-size: 16px; font-weight: bold; }
        .total-price { background: #eee; padding: 15px; text-align: center; border: 2px solid #000; font-size: 24px; font-weight: bold; color: #000; margin-top: 20px; }
        
        /* Hide buttons when printing */
        @media print {
            .btn-print, .btn-close { display: none; }
            body { padding-top: 0; }
            .ticket { border: 2px solid black; width: 100%; max-width: 100%; }
        }
        
        .btn-print { background: #2d3748; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; margin-top: 20px; }
    </style>
</head>
<body>

    <div class="ticket">
        <div class="header">
            <h2>🚂 INDIAN RAILWAYS</h2>
            <p class="success-msg">E-TICKET RESERVATION SLIP</p>
        </div>

        <div class="row">
            <div>
                <span class="label">TRAIN</span><br>
                <span class="value"><%= res.getTrainName() %> (<%= res.getTrainNumber() %>)</span>
            </div>
            <div>
                 <span class="label">PNR / ID</span><br>
                 <span class="value">#<%= res.getReservationId() %></span>
            </div>
        </div>
        
        <div class="row">
            <div>
                <span class="label">ROUTE</span><br>
                <span class="value"><%= res.getSourceStation() %> ➝ <%= res.getDestinationStation() %></span>
            </div>
        </div>

        <div class="row">
            <div>
                <span class="label">PASSENGER</span><br>
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
                <span class="label">SEATS</span><br>
                <span class="value"><%= res.getSeatsBooked() %></span>
            </div>
        </div>
        
        <div class="row">
             <div>
                <span class="label">STATUS</span><br>
                <span class="value">CONFIRMED</span>
            </div>
        </div>

        <div class="total-price">
            TOTAL PAID: ₹<%= res.getTotalFare() %>
        </div>
    </div>

    <div style="text-align: center;">
        <button onclick="window.print()" class="btn-print">🖨️ Print / Save as PDF</button>
        <br><br>
        <a href="my-bookings.jsp" class="btn-close" style="color: blue;">Close</a>
    </div>

</body>
</html>