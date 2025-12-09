package com.railway.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat; // 🆕 Import needed for Date
import java.util.Date;             // 🆕 Import needed for Date
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;
import com.railway.model.Train;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get input
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String dateStr = request.getParameter("date"); 
        
        // 🛡️ SECURITY FIX: Check if date is in the past
        // If someone bypasses the HTML calendar, this Java code catches them!
        try {
            if (dateStr != null && !dateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date journeyDate = sdf.parse(dateStr);
                Date today = new Date();
                
                // Reset today's time to 00:00:00 so we only compare the Date, not hours
                today.setHours(0); today.setMinutes(0); today.setSeconds(0);
                
                if (journeyDate.before(today)) {
                    // 🛑 STOP! Date is in the past.
                    request.setAttribute("errorMessage", "⚠️ Invalid Date: You cannot travel in the past!");
                    request.getRequestDispatcher("search-trains.jsp").forward(request, response);
                    return; // Exit the method immediately
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // ---------------------------------------------------------
        
        // 2. Call DAO (Only happens if Date is valid)
        TrainDAO trainDAO = new TrainDAO();
        List<Train> trainList = trainDAO.searchTrains(source, destination);
        
        // 3. Store results in Request scope
        request.setAttribute("trainList", trainList);
        request.setAttribute("journeyDate", dateStr);
        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        
        // 4. Send to Results Page
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}