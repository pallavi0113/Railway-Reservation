package com.railway.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;
import com.railway.model.Train;
import com.railway.model.StationStop;

@WebServlet("/ManageRouteServlet")
public class ManageRouteServlet extends HttpServlet {
    
    // SHOW PAGE: List all stops for a specific train
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int trainId = Integer.parseInt(request.getParameter("trainId"));
        TrainDAO dao = new TrainDAO();

        // Optional: Delete Logic
        if ("delete".equals(action)) {
            int distId = Integer.parseInt(request.getParameter("distId"));
            dao.deleteStation(distId);
            response.sendRedirect("ManageRouteServlet?trainId=" + trainId); // Refresh page
            return;
        }

        // Standard Load Logic
        Train t = dao.getTrainById(trainId);
        List<StationStop> stops = dao.getTrainStops(trainId);
        
        request.setAttribute("train", t);
        request.setAttribute("stops", stops);
        request.getRequestDispatcher("manage-route.jsp").forward(request, response);
    }

    // ADD STOP: Form submits here
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int trainId = Integer.parseInt(request.getParameter("trainId"));
        String stationName = request.getParameter("stationName");
        int km = Integer.parseInt(request.getParameter("km"));
        
        TrainDAO dao = new TrainDAO();
        dao.addStation(trainId, stationName, km);
        
        // Refresh the page to show the new stop
        response.sendRedirect("ManageRouteServlet?trainId=" + trainId);
    }
}