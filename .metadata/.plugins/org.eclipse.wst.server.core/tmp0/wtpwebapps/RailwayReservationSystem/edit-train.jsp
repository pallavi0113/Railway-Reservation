<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.Train" %>
<%@ include file="navbar.jsp" %>
<% Train t = (Train) request.getAttribute("train"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Train</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding-top: 30px; display:flex; justify-content:center;}
        .form-container { background: white; padding: 40px; border-radius: 10px; width: 600px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); border-top: 5px solid #4299e1; }
        h2 { text-align: center; color: #2d3748; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #4a5568; }
        input { width: 100%; padding: 10px; border: 1px solid #cbd5e0; border-radius: 5px; box-sizing: border-box; }
        .btn-update { width: 100%; padding: 15px; background: #4299e1; color: white; border: none; font-weight: bold; border-radius: 5px; cursor: pointer; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>✏ Edit Train Details</h2>
        
        <form action="EditTrainServlet" method="post">
            <input type="hidden" name="trainId" value="<%= t.getTrainId() %>">
            
            <div class="form-grid">
                <div> <label>Train Name</label> <input type="text" name="trainName" value="<%= t.getTrainName() %>"> </div>
                <div> <label>Train Number</label> <input type="text" name="trainNumber" value="<%= t.getTrainNumber() %>"> </div>
                <div> <label>Source</label> <input type="text" name="source" value="<%= t.getSourceStation() %>"> </div>
                <div> <label>Destination</label> <input type="text" name="dest" value="<%= t.getDestinationStation() %>"> </div>
                <div> <label>Departure</label> <input type="text" name="depTime" value="<%= t.getDepartureTime() %>"> </div>
                <div> <label>Arrival</label> <input type="text" name="arrTime" value="<%= t.getArrivalTime() %>"> </div>
                <div> <label>Total Seats</label> <input type="number" name="seats" value="<%= t.getTotalSeats() %>"> </div>
                <div> <label>Base Fare</label> <input type="number" name="fare" value="<%= t.getFare() %>"> </div>
            </div>

            <button type="submit" class="btn-update">Update Train</button>
            <br><br>
            <center><a href="ManageTrainServlet" style="color:grey; text-decoration:none;">Cancel</a></center>
        </form>
    </div>
</body>
</html>