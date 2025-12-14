<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.railway.model.Train, com.railway.model.StationStop" %>
<%@ include file="navbar.jsp" %>
<% 
    Train t = (Train) request.getAttribute("train"); 
    List<StationStop> stops = (List<StationStop>) request.getAttribute("stops");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Route</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; padding: 20px; }
        .container { max-width: 900px; margin: 0 auto; display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        
        /* Left: Route Table */
        .route-box { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2 { color: #2d3748; margin-top: 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 10px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #667eea; color: white; }
        
        /* Right: Add Form */
        .add-box { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); height: fit-content; border-top: 5px solid #48bb78; }
        input { width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .btn-add { width: 100%; padding: 10px; background: #48bb78; color: white; border: none; font-weight: bold; border-radius: 5px; cursor: pointer; }
        .btn-del { color: red; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

    <h2 style="text-align:center; width:100%;">📍 Route Manager: <%= t.getTrainName() %></h2>
    <div style="text-align:center; margin-bottom:20px;">
        <a href="ManageTrainServlet" style="color:#667eea; text-decoration:none;">← Back to Train List</a>
    </div>

    <div class="container">
        <div class="route-box">
            <h3>Current Stops</h3>
            <table>
                <tr>
                    <th>Station Name</th>
                    <th>Distance (km)</th>
                    <th>Action</th>
                </tr>
                <% for(StationStop s : stops) { %>
                <tr>
                    <td><%= s.getStationName() %></td>
                    <td><%= s.getKmFromSource() %> km</td>
                    <td>
                        <a href="ManageRouteServlet?action=delete&distId=<%= s.getDistanceId() %>&trainId=<%= t.getTrainId() %>" 
                           onclick="return confirm('Remove this stop?')" class="btn-del">× Remove</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>

        <div class="add-box">
            <h3>➕ Add New Stop</h3>
            <form action="ManageRouteServlet" method="post">
                <input type="hidden" name="trainId" value="<%= t.getTrainId() %>">
                
                <label>Station Name</label>
                <input type="text" name="stationName" placeholder="Ex: Kanpur" required>
                
                <label>Distance from Source (km)</label>
                <input type="number" name="km" placeholder="Ex: 850" required>
                
                <button type="submit" class="btn-add">Add Station</button>
            </form>
            <p style="font-size:12px; color:grey; margin-top:10px;">
                *Ensure the distance is correct relative to the Source (0km).
            </p>
        </div>
    </div>

</body>
</html>