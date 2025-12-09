package com.railway.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.ReservationDAO;
import com.railway.dao.TrainDAO;
import com.railway.model.Reservation;
import com.railway.model.User;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get User from Session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null) { response.sendRedirect("login.jsp"); return; }

        // 2. GET FORM DATA (Updated to get Distance & Class)
        int trainId = Integer.parseInt(request.getParameter("trainId"));
        String dateStr = request.getParameter("date");
        String passengerName = request.getParameter("passengerName");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        int seatsToBook = Integer.parseInt(request.getParameter("seats"));
        
        // 🆕 NEW PARAMETERS
        String trainClass = request.getParameter("trainClass"); // e.g. "1AC", "SL", "GN"
        
        // Safety check for distance (default to 0 if missing)
        String distStr = request.getParameter("distance");
        int distance = (distStr != null && !distStr.isEmpty()) ? Integer.parseInt(distStr) : 0;


        // 3. 🧠 HYBRID PRICING LOGIC (10/20 Rs vs AC/Sleeper)
        double pricePerTicket = 0.0;

        // RULE A: Local / Short Distance Logic
        if (distance <= 20) {
            pricePerTicket = 10.0; // Fixed 10 Rs
        } 
        else if (distance <= 50) {
            pricePerTicket = 20.0; // Fixed 20 Rs
        }
        else if (distance <= 100 && "GN".equals(trainClass)) {
            pricePerTicket = 30.0; // Fixed 30 Rs for General short distance
        }
        // RULE B: Long Distance / Class Logic
        else {
            double ratePerKm = 0.4; // Default General Rate
            
            if ("1AC".equals(trainClass)) ratePerKm = 3.5;
            else if ("2AC".equals(trainClass)) ratePerKm = 2.5;
            else if ("3AC".equals(trainClass)) ratePerKm = 1.5;
            else if ("SL".equals(trainClass)) ratePerKm = 0.8;
            
            pricePerTicket = distance * ratePerKm;
            
            // Optional: Minimum fare rule for luxury classes
            if("1AC".equals(trainClass) && pricePerTicket < 1000) pricePerTicket = 1000;
        }
        
        // Calculate Total
        double totalFare = pricePerTicket * seatsToBook;


        // 4. Check & Update Seat Availability
        TrainDAO trainDAO = new TrainDAO();
        boolean seatsUpdated = trainDAO.updateAvailableSeats(trainId, seatsToBook);

        if (seatsUpdated) {
            // 5. Create Reservation Object
            Reservation res = new Reservation();
            res.setUserId(user.getUserId());
            res.setTrainId(trainId);
            res.setPassengerName(passengerName);
            res.setAge(age);
            res.setGender(gender);
            res.setJourneyDate(java.sql.Date.valueOf(dateStr));
            res.setSeatsBooked(seatsToBook);
            res.setTotalFare(totalFare);
            res.setBookingStatus("CONFIRMED");
            
            // 6. Save to Database
            ReservationDAO bookingDAO = new ReservationDAO();
            boolean booked = bookingDAO.bookTicket(res);
            
            if (booked) {
                request.setAttribute("reservation", res);
                request.getRequestDispatcher("booking-success.jsp").forward(request, response);
            } else {
                response.getWriter().println("Error: Database insertion failed.");
            }
        } else {
            request.setAttribute("errorMessage", "Booking Failed! Not enough seats available.");
            request.getRequestDispatcher("search-trains.jsp").forward(request, response);
        }
    }
}