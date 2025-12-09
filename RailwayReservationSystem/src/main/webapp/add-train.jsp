<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Train</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; display: flex; justify-content: center; padding-top: 30px; }
        .form-container { background: white; padding: 40px; border-radius: 10px; width: 600px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2d3748; margin-bottom: 20px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #4a5568; }
        input { width: 100%; padding: 10px; border: 1px solid #cbd5e0; border-radius: 5px; box-sizing: border-box; }
        .full-width { grid-column: span 2; }
        .btn-submit { width: 100%; padding: 15px; background: #48bb78; color: white; border: none; font-weight: bold; font-size: 16px; border-radius: 5px; cursor: pointer; margin-top: 20px; }
        .btn-submit:hover { background: #38a169; }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>➕ Add New Train</h2>
        
        <form action="AddTrainServlet" method="post">
            <div class="form-grid">
                <div>
                    <label>Train Name</label>
                    <input type="text" name="trainName" placeholder="Ex: Chennai Express" required>
                </div>
                <div>
                    <label>Train Number</label>
                    <input type="text" name="trainNumber" placeholder="Ex: 12840" required>
                </div>

                <div>
                    <label>Source Station</label>
                    <input type="text" name="source" placeholder="Ex: Chennai" required>
                </div>
                <div>
                    <label>Destination</label>
                    <input type="text" name="dest" placeholder="Ex: Howrah" required>
                </div>

                <div>
                    <label>Departure Time</label>
                    <input type="text" name="depTime" placeholder="HH:MM (24hr)" required>
                </div>
                <div>
                    <label>Arrival Time</label>
                    <input type="text" name="arrTime" placeholder="HH:MM (24hr)" required>
                </div>

                <div>
                    <label>Total Seats</label>
                    <input type="number" name="seats" value="500" required>
                </div>
                <div>
                    <label>Base Fare (General)</label>
                    <input type="number" name="baseFare" placeholder="Ex: 300" required>
                </div>
                
                <div class="full-width">
                    <label>Total Distance (km)</label>
                    <input type="number" name="distance" placeholder="Enter KM (Important for pricing!)" required>
                </div>
            </div>

            <button type="submit" class="btn-submit">Add Train to System</button>
        </form>
        
        <div style="text-align:center; margin-top:15px;">
            <a href="admin-dashboard.jsp" style="color:#667eea;">Cancel</a>
        </div>
    </div>

</body>
</html>