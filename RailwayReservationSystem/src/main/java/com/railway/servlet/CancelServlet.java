package com.railway.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.ReservationDAO;
import com.railway.model.User; // Import User model

@WebServlet("/CancelServlet")
public class CancelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get Reservation ID
        String idStr = request.getParameter("id");
        if(idStr != null) {
            int resId = Integer.parseInt(idStr);
            
            // 2. Call DAO to Cancel
            ReservationDAO dao = new ReservationDAO();
            boolean cancelled = dao.cancelTicket(resId);
            
            // 3. CHECK WHO IS LOGGED IN (To decide where to redirect)
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            if(cancelled) {
                if (currentUser != null && "ADMIN".equals(currentUser.getRole())) {
                    // If Admin clicked it -> Go back to Admin List
                    response.sendRedirect("AllBookingsServlet?msg=CancelledByAdmin");
                } else {
                    // If User clicked it -> Go back to User Dashboard
                    response.sendRedirect("my-bookings.jsp?msg=Cancelled");
                }
            } else {
                response.sendRedirect("my-bookings.jsp?msg=Error");
            }
        } else {
            response.sendRedirect("my-bookings.jsp");
        }
    }
}