<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.dao.TrainDAO, com.railway.model.Train, com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) { response.sendRedirect("login.jsp"); return; }

    // Get Data from URL
    String trainIdStr = request.getParameter("trainId");
    String date = request.getParameter("date");
    String trainClass = request.getParameter("trainClass"); 
    String distance = request.getParameter("distance");
    String searchSource = request.getParameter("source");
    String searchDest = request.getParameter("destination");
    
    TrainDAO dao = new TrainDAO();
    Train train = dao.getTrainById(Integer.parseInt(trainIdStr));
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Ticket</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; margin:0; }
        .container { max-width: 600px; margin: 40px auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .info-box { background: #ebf8ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #4299e1; }
        label { display: block; font-weight: bold; margin-top: 15px; color: #4a5568; }
        input, select { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #cbd5e0; border-radius: 5px; }
        .price-display { background: #f0fff4; color: #276749; padding: 15px; font-size: 20px; font-weight: bold; text-align: center; margin-top: 20px; border: 2px dashed #48bb78; border-radius: 10px; }
        .btn-pay { width: 100%; padding: 15px; background: #48bb78; color: white; border: none; font-size: 18px; font-weight: bold; border-radius: 5px; margin-top: 10px; cursor: pointer; }
        .btn-pay:hover { background: #38a169; }
    </style>
    
    <script>
        // 🧠 JS Logic to Show Price Instantly (Matches your Servlet Logic)
        function calculateLivePrice() {
            var distance = <%= distance %>;
            var trainClass = "<%= trainClass %>";
            var seats = document.getElementById("seats").value;
            var pricePerTicket = 0;

            // Short Distance Logic
            if (distance <= 20) pricePerTicket = 10;
            else if (distance <= 50) pricePerTicket = 20;
            else if (distance <= 100 && trainClass === "GN") pricePerTicket = 30;
            else {
                // Long Distance Logic
                var rate = 0.4;
                if (trainClass === "SL") rate = 0.8;
                if (trainClass === "3AC") rate = 1.5;
                if (trainClass === "2AC") rate = 2.5;
                if (trainClass === "1AC") rate = 3.5;
                pricePerTicket = distance * rate;
                
                // Min Fares
                if (trainClass === "1AC" && pricePerTicket < 1000) pricePerTicket = 1000;
            }

            var total = Math.round(pricePerTicket * seats);
            document.getElementById("totalPrice").innerText = "₹" + total;
        }
    </script>
</head>
<body onload="calculateLivePrice()">
    
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <h2 style="text-align: center;">Confirm Booking</h2>
        
        <div class="info-box">
            <p><strong>Train:</strong> <%= train.getTrainName() %> (<%= train.getTrainNumber() %>)</p>
            <p><strong>Route:</strong> <%= searchSource %> ➝ <%= searchDest %> (<%= distance %> km)</p>
            <p><strong>Date:</strong> <%= date %> | <strong>Class:</strong> <%= trainClass %></p>
        </div>

        <form action="BookingServlet" method="post">
            <input type="hidden" name="trainId" value="<%= train.getTrainId() %>">
            <input type="hidden" name="date" value="<%= date %>">
            <input type="hidden" name="source" value="<%= searchSource %>">
            <input type="hidden" name="destination" value="<%= searchDest %>">
            <input type="hidden" name="trainClass" value="<%= trainClass %>">
            <input type="hidden" name="distance" value="<%= distance %>">
            
            <label>Passenger Name</label>
            <input type="text" name="passengerName" required>
            
            <label>Age</label>
            <input type="number" name="age" required>
            
            <label>Gender</label>
            <select name="gender">
                <option>Male</option> <option>Female</option> <option>Other</option>
            </select>
            
            <label>Seats</label>
            <input type="number" id="seats" name="seats" value="1" min="1" max="6" oninput="calculateLivePrice()" required>
            
            <div class="price-display">
                Total Pay: <span id="totalPrice">Calculating...</span>
            </div>

            <button type="submit" class="btn-pay">Pay & Book</button>
        </form>
    </div>
</body>
</html>