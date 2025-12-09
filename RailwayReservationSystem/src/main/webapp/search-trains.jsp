<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %> <!DOCTYPE html>
<html>
<head>
    <title>Search Trains</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; display: flex; justify-content: center; padding-top: 50px; }
        .search-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 400px; }
        h2 { text-align: center; color: #2d3748; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; color: #718096; margin-bottom: 5px; font-weight: 600; }
        input { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 5px; }
        .btn-search { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-search:hover { background: #5a67d8; }
    </style>
</head>
<body>
    <div class="search-box">
        <h2>🔍 Find Your Train</h2>
        <form action="SearchServlet" method="get">
            <div class="form-group">
                <label>Source Station</label>
                <input type="text" name="source" placeholder="Ex: New Delhi" required>
            </div>
            <div class="form-group">
                <label>Destination Station</label>
                <input type="text" name="destination" placeholder="Ex: Mumbai" required>
            </div>
            <div class="form-group">
                <label>Journey Date</label>
                <input type="date" name="date" id="journeyDate" required>
            </div>
            <button type="submit" class="btn-search">Search Trains</button>
        </form>
        <div style="text-align: center; margin-top: 20px;">
            <a href="user-dashboard.jsp" style="color: #667eea; text-decoration: none;">← Back to Dashboard</a>
        </div>
    </div>
</body>
<script>
    // Get today's date in YYYY-MM-DD format
    var today = new Date().toISOString().split('T')[0];
    // Set it as the minimum value for the date picker
    document.getElementsByName("date")[0].setAttribute('min', today);
</script>
</html>