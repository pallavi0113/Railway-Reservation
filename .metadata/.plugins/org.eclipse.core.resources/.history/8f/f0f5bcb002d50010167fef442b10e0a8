<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Railway Reservation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f7fafc; }
        .navbar { background: #667eea; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 15px; border-radius: 5px; transition: 0.3s; }
        .navbar a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .welcome h2 { color: #333; margin-bottom: 10px; }
        .user-info { background: #f7fafc; padding: 15px; border-radius: 5px; margin-top: 15px; }
        .user-info p { margin: 5px 0; color: #555; }
        
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); transition: 0.3s; text-align: center; border-left: 5px solid #667eea; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(0,0,0,0.1); }
        .card h3 { color: #2d3748; margin-bottom: 15px; font-size: 20px; }
        .card p { color: #718096; margin-bottom: 20px; line-height: 1.5; }
        .btn-card { display: inline-block; padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-card:hover { background: #5a67d8; }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🚂 Railway Reservation System</h1>
        <div>
            <a href="user-dashboard.jsp">Dashboard</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="welcome">
            <h2>Welcome, <%= user.getFullName() %>! 👋</h2>
            <p>You have successfully logged in to the Railway Reservation System</p>
            
            <div class="user-info">
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                <p><strong>Role:</strong> <%= user.getRole() %></p>
            </div>
        </div>
        

        <div class="dashboard-grid">
            <div class="card">
                <h3>🔍 Search Trains</h3>
                <p>Find trains between stations, check seat availability, and view routes.</p>
                <a href="search-trains.jsp" class="btn-card">Find Trains</a>
            </div>

            <div class="card" style="border-left-color: #ed8936;">
                <h3>🎫 My Bookings</h3>
                <p>View your upcoming journeys, download tickets, or cancel reservations.</p>
                <a href="my-bookings.jsp" class="btn-card" style="background-color: #ed8936;">View Bookings</a>
            </div>
        </div>
    </div>
</body>
</html>
