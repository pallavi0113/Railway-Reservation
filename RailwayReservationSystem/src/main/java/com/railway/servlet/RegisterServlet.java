package com.railway.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.railway.dao.UserDAO;
import com.railway.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get data from HTML form
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
     // Regex: Checks for at least 1 letter, 1 number, and min 6 characters
        String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d).{6,}$";

        if (!password.matches(passwordPattern)) {
            request.setAttribute("errorMessage", "Password must contain letters, numbers, and be 6+ chars long!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // STOP execution here
        }
     // 2. Create User object
        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole("CUSTOMER"); // Default role for new registrations
        
        // 3. Save to Database using your existing UserDAO
        boolean isRegistered = userDAO.registerUser(newUser);
        
        if (isRegistered) {
            // Success: Send them to Login page
            // We can add a small attribute to show a success message on login page if you want
            response.sendRedirect("login.jsp");
        } else {
            // Failure: Stay on Register page and show error
            request.setAttribute("errorMessage", "Registration Failed! Username or Email might already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
