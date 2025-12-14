<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.railway.model.Train" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Trains</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding: 20px; }
        .container { max-width: 1100px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2d3748; margin-bottom: 20px; }
        
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background: #667eea; color: white; }
        tr:hover { background-color: #f1f1f1; }
        
        .btn { padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold; }
        .btn-edit { background: #4299e1; color: white; }
        .btn-delete { background: #e53e3e; color: white; margin-left: 5px; }
        .btn-add { display:inline-block; background: #48bb78; color:white; padding: 10px 15px; margin-bottom: 15px; text-decoration:none; border-radius:5px; font-weight:bold;}
    </style>
</head>
<body>
    <div class="container">
        <h2>🚆 Manage Train Schedules</h2>
        
        <a href="add-train.jsp" class="btn-add">➕ Add New Train</a>
        
        <table>
            <tr>
                <th>ID</th>
                <th>Name / Number</th>
                <th>Route</th>
                <th>Timings</th>
                <th>Seats</th>
                <th>Actions</th>
            </tr>
            <% 
                List<Train> list = (List<Train>) request.getAttribute("trainList");
                if (list != null) {
                    for (Train t : list) {
            %>
            <tr>
                <td><%= t.getTrainId() %></td>
                <td><%= t.getTrainName() %> <br> <small style="color:grey"><%= t.getTrainNumber() %></small></td>
                <td><%= t.getSourceStation() %> ➝ <%= t.getDestinationStation() %></td>
                <td>Dep: <%= t.getDepartureTime() %> <br> Arr: <%= t.getArrivalTime() %></td>
                <td><%= t.getAvailableSeats() %> / <%= t.getTotalSeats() %></td>
                <td>
                    <a href="ManageRouteServlet?trainId=<%= t.getTrainId() %>" class="btn" style="background:#805ad5; color:white; margin-right:5px;">📍 Route</a>

                    <a href="EditTrainServlet?id=<%= t.getTrainId() %>" class="btn btn-edit">✏ Edit</a>

                    <a href="DeleteTrainServlet?id=<%= t.getTrainId() %>" onclick="return confirm('Delete this train?')" class="btn btn-delete">🗑</a>
                </td>
            </tr>
            <% 
                    }
                } 
            %>
        </table>
    </div>
</body>
</html>