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

        // 2. Get Form Data
        int trainId = Integer.parseInt(request.getParameter("trainId"));
        String dateStr = request.getParameter("date");
        
        // --- CHANGED: We get Source/Dest instead of Fare to calculate price ---
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");

        String passengerName = request.getParameter("passengerName");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        int seatsToBook = Integer.parseInt(request.getParameter("seats"));

        // 3. CALCULATE LOCAL TRAIN PRICE (10, 20, 25, 30 Rs) 💰
        double ticketPrice = calculateLocalFare(source, destination);
        
        // Optional: Half price for kids under 10
        if(age < 10) {
            ticketPrice = ticketPrice / 2;
        }

        double totalFare = ticketPrice * seatsToBook;

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

    // --- NEW HELPER METHOD FOR PRICING ---
    private double calculateLocalFare(String source, String destination) {
        if(source == null || destination == null) return 30.0; // Safety check
        
        String s = source.toLowerCase();
        String d = destination.toLowerCase();

        // 10 Rs Route
        if ((s.contains("mumbai") && d.contains("dadar")) || 
            (s.contains("delhi") && d.contains("noida"))) {
            return 10.0;
        }

        // 20 Rs Route
        if ((s.contains("mumbai") && d.contains("thane")) || 
            (s.contains("delhi") && d.contains("gurgaon"))) {
            return 20.0;
        }

        // 25 Rs Route
        if ((s.contains("mumbai") && d.contains("kalyan")) || 
            (s.contains("chennai") && d.contains("bangalore"))) {
            return 25.0;
        }

        // Default for all other routes
        return 30.0;
    }
}