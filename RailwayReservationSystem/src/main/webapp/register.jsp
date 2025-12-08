<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Railway Reservation</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 500px; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #666; font-weight: 600; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-size: 14px; transition: 0.3s; }
        input:focus { border-color: #667eea; outline: none; box-shadow: 0 0 5px rgba(102, 126, 234, 0.3); }
        .btn { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn:hover { background: #764ba2; }
        .login-link { text-align: center; margin-top: 20px; font-size: 14px; }
        .login-link a { color: #667eea; text-decoration: none; font-weight: bold; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>

    <div class="container">
        <h2>📝 Create Account</h2>
        
        <% String error = (String) request.getAttribute("errorMessage");
           if(error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullname" placeholder="Ex: Pallavi Shrivastva" required>
            </div>
            
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Ex: pallavi@example.com" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" name="phone" placeholder="Ex: 9876543210" pattern="[0-9]{10}" title="Please enter valid 10 digit number" required>
            </div>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Choose a unique username" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" 
			           placeholder="Min 6 chars, 1 letter, 1 number" 
			           pattern="^(?=.*[A-Za-z])(?=.*\d).{6,}$"
			           title="Password must be at least 6 characters long and contain both letters and numbers."
			           required>
			</div>

            <button type="submit" class="btn">Register Now</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

</body>
</html>