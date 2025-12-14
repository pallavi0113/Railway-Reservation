<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; margin: 0; }
        .container { max-width: 1000px; margin: 50px auto; padding: 20px; text-align: center; }
        .greeting { font-size: 28px; color: #2d3748; margin-bottom: 40px; }
        
        .action-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; }
        
        .card { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 20px rgba(0,0,0,0.05); transition: 0.3s; border-top: 5px solid #667eea; text-decoration: none; color: inherit; }
        .card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .card h3 { color: #4a5568; font-size: 24px; margin-bottom: 10px; }
        .card p { color: #718096; }
        .icon { font-size: 50px; margin-bottom: 20px; display: block; }
    </style>
</head>
<body>
    
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <h2 class="greeting">Hello, <%= user.getFullName().split(" ")[0] %>! Where do you want to go?</h2>
        
        <div class="action-grid">
            <a href="search-trains.jsp" class="card">
                <span class="icon">🔍</span>
                <h3>Search Trains</h3>
                <p>Book tickets for local and express trains.</p>
            </a>

            <a href="my-bookings.jsp" class="card" style="border-top-color: #ed8936;">
                <span class="icon">🎫</span>
                <h3>My Bookings</h3>
                <p>View history, check status, and download tickets.</p>
            </a>
        </div>
    </div>
</body>
</html>