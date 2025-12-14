<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.util.ArrayList, com.railway.model.Train" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding: 30px; }
        .container { max-width: 900px; margin: 0 auto; }
        .header { margin-bottom: 30px; text-align: center; }
        .train-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-left: 5px solid #667eea; }
        .train-info h3 { margin: 0 0 5px 0; color: #2d3748; }
        .train-route { color: #718096; font-size: 14px; }
        .train-time { font-weight: bold; color: #4a5568; margin-top: 10px; }
        .price-tag { font-size: 24px; color: #2b6cb0; font-weight: bold; }
        .btn-book { padding: 10px 25px; background: #48bb78; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s; }
        .btn-book:hover { background: #38a169; }
        .no-results { text-align: center; margin-top: 50px; color: #718096; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>🚂 Trains from <%= request.getAttribute("source") %> to <%= request.getAttribute("destination") %></h2>
            <p>Date: <%= request.getAttribute("journeyDate") %></p>
            <a href="search-trains.jsp">← New Search</a>
        </div>

        <% 
            List<Train> trains = (List<Train>) request.getAttribute("trainList");
            String journeyDate = (String) request.getAttribute("journeyDate");

            if (trains != null && !trains.isEmpty()) {
                for (Train t : trains) {
        %>
            <div class="train-card">
                <div class="train-info">
                    <h3><%= t.getTrainName() %> (<%= t.getTrainNumber() %>)</h3>
                    <div class="train-route">
                        <%= t.getSourceStation() %> ➝ <%= t.getDestinationStation() %>
                    </div>
                    <div class="train-time">
                        Dep: <%= t.getDepartureTime() %> | Arr: <%= t.getArrivalTime() %>
                    </div>
                    <div style="margin-top: 5px; color: <%= t.getAvailableSeats() > 0 ? "green" : "red" %>;">
                        Available Seats: <%= t.getAvailableSeats() %>
                    </div>
                </div>
                
                <div style="text-align: right;">
                    <div class="price-tag">₹<%= t.getFare() %></div>
                    <br>
                    <% if(t.getAvailableSeats() > 0) { %>
                        <a href="book-ticket.jsp?trainId=<%= t.getTrainId() %>&date=<%= journeyDate %>" class="btn-book">Book Now</a>
                    <% } else { %>
                        <span style="color: red; font-weight: bold;">SOLD OUT</span>
                    <% } %>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <div class="no-results">
                <h3>😕 No trains found.</h3>
                <p>Try searching for "New Delhi" to "Mumbai" (From your sample data)</p>
            </div>
        <% } %>
    </div>
</body>
</html>