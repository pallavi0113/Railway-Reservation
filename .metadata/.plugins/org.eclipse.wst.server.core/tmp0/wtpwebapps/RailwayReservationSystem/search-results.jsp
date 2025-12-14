<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.util.ArrayList, com.railway.model.Train" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding: 30px; }
        .container { max-width: 1000px; margin: 0 auto; }
        
        /* Header */
        .header { margin-bottom: 30px; text-align: center; }
        .header h2 { color: #2d3748; margin: 0; }
        .sub-header { color: #718096; margin-top: 5px; }
        
        /* Train Card */
        .train-card { 
            background: white; 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.05); 
            margin-bottom: 25px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            border-left: 6px solid #667eea; 
            transition: 0.3s;
        }
        .train-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }

        /* Left Section: Train Info */
        .train-info { flex: 2; }
        .train-name { font-size: 20px; font-weight: bold; color: #2d3748; }
        .train-number { background: #edf2f7; padding: 2px 8px; border-radius: 4px; font-size: 14px; color: #4a5568; margin-left: 10px; }
        
        /* The Journey Display (Source -> Dest) */
        .journey-route { font-size: 18px; font-weight: bold; color: #5a67d8; margin-top: 10px; display: flex; align-items: center; gap: 10px; }
        
        /* The "In-Between" Full Route display */
        .via-route { font-size: 13px; color: #718096; margin-top: 5px; background: #fff5f5; padding: 5px; border-radius: 4px; display: inline-block; }
        
        .train-time { font-weight: bold; color: #4a5568; margin-top: 10px; font-size: 14px; }
        .distance-badge { background: #fefcbf; color: #744210; padding: 3px 8px; border-radius: 10px; font-size: 12px; font-weight: bold; margin-left: 10px; }

        /* Right Section: Booking */
        .booking-section { flex: 1; text-align: right; border-left: 1px solid #eee; padding-left: 20px; }
        .seat-green { color: #38a169; font-weight: bold; font-size: 14px; margin-bottom: 10px; display: block; }
        .seat-red { color: #e53e3e; font-weight: bold; }
        
        select { padding: 8px; border-radius: 5px; border: 1px solid #cbd5e0; width: 100%; margin-bottom: 10px; }
        .btn-book { width: 100%; padding: 10px; background: #48bb78; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; transition: 0.2s; }
        .btn-book:hover { background: #38a169; }
        
        .no-results { text-align: center; margin-top: 50px; color: #718096; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>🚄 <%= request.getAttribute("source") %> ➝ <%= request.getAttribute("destination") %></h2>
            <div class="sub-header">Journey Date: <%= request.getAttribute("journeyDate") %></div>
            <br>
            <a href="search-trains.jsp" style="text-decoration:none; color:#667eea; font-weight:bold;">← New Search</a>
        </div>

        <% 
            List<Train> trains = (List<Train>) request.getAttribute("trainList");
            String journeyDate = (String) request.getAttribute("journeyDate");
            
            // Search Parameters
            String searchSource = (String) request.getAttribute("source");
            String searchDest = (String) request.getAttribute("destination");

            if (trains != null && !trains.isEmpty()) {
                for (Train t : trains) {
        %>
            <div class="train-card">
                <div class="train-info">
                    <div>
                        <span class="train-name"><%= t.getTrainName() %></span>
                        <span class="train-number"><%= t.getTrainNumber() %></span>
                    </div>
                    
                    <div class="journey-route">
                        <%= searchSource %> ➝ <%= searchDest %>
                        <span class="distance-badge">📍 <%= t.getJourneyDistance() %> km</span>
                    </div>

                    <div class="via-route">
                        <strong>Full Route:</strong> <%= t.getViaStations() %>
                    </div>

                    <div class="train-time">
                        🕒 Dep: <%= t.getDepartureTime() %> | Arr: <%= t.getArrivalTime() %>
                    </div>
                </div>
                
                <div class="booking-section">
                    <% if(t.getAvailableSeats() > 0) { %>
                        <span class="seat-green">✔ <%= t.getAvailableSeats() %> Seats Available</span>
                        
                        <form action="book-ticket.jsp" method="get">
                            <input type="hidden" name="trainId" value="<%= t.getTrainId() %>">
                            <input type="hidden" name="date" value="<%= journeyDate %>">
                            <input type="hidden" name="source" value="<%= searchSource %>">
                            <input type="hidden" name="destination" value="<%= searchDest %>">
                            <input type="hidden" name="distance" value="<%= t.getJourneyDistance() %>">

                            <select name="trainClass">
                                <option value="GN">General</option>
                                <option value="SL">Sleeper</option>
                                <option value="3AC">3rd AC</option>
                                <option value="2AC">2nd AC</option>
                                <option value="1AC">1st AC</option>
                            </select>
                            
                            <button type="submit" class="btn-book">Book Now</button>
                        </form>

                    <% } else { %>
                        <span class="seat-red">❌ SOLD OUT</span>
                    <% } %>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <div class="no-results">
                <h3>😕 No trains found directly connecting these stations.</h3>
                <p>Try searching for major stations like "Kolkata" or "Delhi".</p>
            </div>
        <% } %>
    </div>
</body>
</html>