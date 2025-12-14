package com.railway.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.ReservationDAO;

@WebServlet("/CancelServlet")
public class CancelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get Reservation ID
        String idStr = request.getParameter("id");
        if(idStr != null) {
            int resId = Integer.parseInt(idStr);
            
            // 2. Call DAO
            ReservationDAO dao = new ReservationDAO();
            boolean cancelled = dao.cancelTicket(resId);
            
            if(cancelled) {
                // Success
                response.sendRedirect("my-bookings.jsp?msg=Cancelled");
            } else {
                // Failure
                response.sendRedirect("my-bookings.jsp?msg=Error");
            }
        } else {
            response.sendRedirect("my-bookings.jsp");
        }
    }
}