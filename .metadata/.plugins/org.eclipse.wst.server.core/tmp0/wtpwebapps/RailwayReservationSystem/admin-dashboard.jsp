<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Railway Reservation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f7fafc; }
        
        .navbar { background: #2d3748; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h1 { font-size: 22px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 15px; border-radius: 5px; transition: 0.3s; font-weight: bold; }
        .navbar a:hover { background: rgba(255,255,255,0.2); }
        
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        
        .welcome { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; border-left: 5px solid #2d3748; }
        .welcome h2 { color: #333; margin-bottom: 10px; }
        
        .admin-badge { background: #f6ad55; color: white; padding: 5px 15px; border-radius: 20px; display: inline-block; margin-left: 10px; font-size: 14px; font-weight: bold; }
        
        .user-info { background: #fff5e6; padding: 20px; border-radius: 5px; margin-top: 15px; border-left: 4px solid #f6ad55; }
        .user-info p { margin: 8px 0; color: #555; }
        
        .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px; }
        
        /* 🛠️ MODIFIED CARD CSS TO MAKE IT CLICKABLE */
        .card { 
            display: block; /* Makes the link behave like a box */
            text-decoration: none; /* Removes the underline */
            background: white; 
            padding: 25px; 
            border-radius: 10px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
            text-align: center; 
            transition: 0.3s; 
            color: inherit; /* Keeps text color normal */
            border-top: 5px solid #cbd5e0;
        }
        
        .card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .card h3 { color: #667eea; margin-bottom: 10px; font-size: 18px; }
        .card p { color: #666; margin-bottom: 15px; font-size: 14px; }
        .card .icon { font-size: 40px; margin-bottom: 10px; }

        /* Specific Colors for buttons */
        .card-green { border-top-color: #48bb78; }
        .card-blue { border-top-color: #4299e1; }
        .card-orange { border-top-color: #ed8936; }
        .card-red { border-top-color: #e53e3e; }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🚂 Admin Control Panel</h1>
        <div>
            <span>👤 <%= user.getFullName() %></span>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="welcome">
            <h2>Welcome, <%= user.getFullName() %>! 👋 <span class="admin-badge">ADMIN</span></h2>
            <p>You have administrator access to the Railway Reservation System</p>
            
            <div class="user-info">
                <p><strong>👤 Username:</strong> <%= user.getUsername() %></p>
                <p><strong>📧 Email:</strong> <%= user.getEmail() %></p>
                <p><strong>🔑 Role:</strong> <%= user.getRole() %></p>
            </div>
        </div>
        
        <div class="cards">
            
            <a href="add-train.jsp" class="card card-green">
                <div class="icon">➕</div>
                <h3>Add New Train</h3>
                <p>Create new trains, set routes, and prices</p>
            </a>

            <a href="ManageTrainServlet" class="card card-blue">
                <div class="icon">🚊</div>
                <h3>Manage Trains</h3>
                <p>Update or remove train schedules</p>
            </a>
            
            <a href="AllBookingsServlet" class="card card-orange">
                <div class="icon">🎫</div>
                <h3>All Bookings</h3>
                <p>View and manage all reservations</p>
            </a>
            
            <a href="LogoutServlet" class="card card-red">
                <div class="icon">🚪</div>
                <h3>Logout</h3>
                <p>Sign out of the admin panel</p>
            </a>
        </div>
    </div>
</body>
</html>