<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Something Went Wrong</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f7fafc; text-align: center; padding-top: 100px; }
        .container { background: white; max-width: 600px; margin: 0 auto; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); border-top: 5px solid #e53e3e; }
        h1 { color: #e53e3e; font-size: 36px; margin-bottom: 10px; }
        p { color: #718096; font-size: 18px; margin-bottom: 30px; }
        .btn { text-decoration: none; background: #2d3748; color: white; padding: 12px 25px; border-radius: 5px; font-weight: bold; transition: 0.3s; }
        .btn:hover { background: #1a202c; }
        .tech-details { margin-top: 30px; text-align: left; background: #fff5f5; padding: 15px; border-radius: 5px; font-size: 12px; color: #c53030; display: none; }
    </style>
    
    <script>
        function toggleDetails() {
            var x = document.getElementById("details");
            if (x.style.display === "none") { x.style.display = "block"; } 
            else { x.style.display = "none"; }
        }
    </script>
</head>
<body>

    <div class="container">
        <h1>⚠️ Oops!</h1>
        <p>Something went wrong while processing your request.</p>
        
        <a href="user-dashboard.jsp" class="btn">🏠 Return to Dashboard</a>
        <br><br>
        
        <a href="#" onclick="toggleDetails()" style="color: #718096; font-size: 12px;">View Technical Details</a>
        
        <div id="details" class="tech-details">
            <strong>Error Message:</strong> <%= exception != null ? exception.getMessage() : "Unknown Error" %>
        </div>
    </div>

</body>
</html>