package com.railway.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;
import com.railway.model.Train;

@WebServlet("/AddTrainServlet")
public class AddTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get Parameters
        String name = request.getParameter("trainName");
        String number = request.getParameter("trainNumber");
        String source = request.getParameter("source");
        String dest = request.getParameter("dest");
        int distance = Integer.parseInt(request.getParameter("distance")); // Needed for logic
        String depTime = request.getParameter("depTime");
        String arrTime = request.getParameter("arrTime");
        int seats = Integer.parseInt(request.getParameter("seats"));
        double baseFare = Double.parseDouble(request.getParameter("baseFare"));

        // 2. Create Object
        Train t = new Train();
        t.setTrainName(name);
        t.setTrainNumber(number);
        t.setSourceStation(source);
        t.setDestinationStation(dest);
        t.setDepartureTime(depTime);
        t.setArrivalTime(arrTime);
        t.setTotalSeats(seats);
        t.setFare(baseFare); // This will be used as General Fare

        // 3. Call DAO
        TrainDAO dao = new TrainDAO();
        boolean isAdded = dao.addTrain(t, distance);

        if (isAdded) {
            response.sendRedirect("admin-dashboard.jsp?msg=TrainAdded");
        } else {
            response.getWriter().println("Error adding train. Check console.");
        }
    }
}