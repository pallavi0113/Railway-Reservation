<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.User" %>
<%
    // 1. SECURITY: Prevent Back Button after Logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // 2. GET USER
    User navUser = (User) session.getAttribute("user");
%>
<style>
    /* Navbar Styling */
    .navbar { background: linear-gradient(90deg, #667eea, #764ba2); color: white; padding: 10px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); font-family: 'Segoe UI', sans-serif; }
    .logo { font-size: 22px; font-weight: bold; text-decoration: none; color: white; display: flex; align-items: center; gap: 10px; }
    
    /* Profile Dropdown */
    .profile-menu { position: relative; display: inline-block; cursor: pointer; }
    .profile-btn { background: rgba(255,255,255,0.2); padding: 8px 15px; border-radius: 20px; font-weight: bold; display: flex; align-items: center; gap: 8px; transition: 0.3s; }
    .profile-btn:hover { background: rgba(255,255,255,0.3); }
    
    /* Dropdown Content */
    .dropdown-content { display: none; position: absolute; right: 0; background-color: white; min-width: 200px; box-shadow: 0 8px 16px rgba(0,0,0,0.2); border-radius: 8px; z-index: 1000; overflow: hidden; margin-top: 10px; }
    .dropdown-content p { color: #2d3748; padding: 12px 16px; margin: 0; border-bottom: 1px solid #edf2f7; font-size: 14px; }
    .dropdown-content a { color: #e53e3e; padding: 12px 16px; text-decoration: none; display: block; font-weight: bold; }
    .dropdown-content a:hover { background-color: #f7fafc; }

    /* Show Dropdown on Hover */
    .profile-menu:hover .dropdown-content { display: block; }
    
    /* Admin Badge Style */
    .admin-badge { background: #e53e3e; color: white; padding: 2px 8px; border-radius: 4px; font-size: 12px; margin-left: 10px; vertical-align: middle; }
</style>

<div class="navbar">
    <div style="display:flex; align-items:center;">
        <a href="user-dashboard.jsp" class="logo">🚂 Railway System</a>
        
        <% if(navUser != null && "ADMIN".equals(navUser.getRole())) { %>
            <span class="admin-badge">ADMIN MODE</span>
        <% } %>
    </div>
    
    <% if (navUser != null) { %>
        <div class="profile-menu">
            <div class="profile-btn">
                👤 <%= navUser.getFullName() %> ▼
            </div>
            <div class="dropdown-content">
                <p><strong>User:</strong> <%= navUser.getUsername() %></p>
                <p><strong>Email:</strong> <%= navUser.getEmail() %></p>
                <p><strong>Phone:</strong> <%= navUser.getPhone() %></p>
                <a href="LogoutServlet">🚪 Logout</a>
            </div>
        </div>
    <% } %>
</div>