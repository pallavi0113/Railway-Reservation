package com.railway.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.ReservationDAO;
import com.railway.model.Reservation;

@WebServlet("/AllBookingsServlet")
public class AllBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ReservationDAO dao = new ReservationDAO();
        List<Reservation> list = dao.getAllReservations();
        
        request.setAttribute("bookingList", list);
        request.getRequestDispatcher("all-bookings.jsp").forward(request, response);
    }
}