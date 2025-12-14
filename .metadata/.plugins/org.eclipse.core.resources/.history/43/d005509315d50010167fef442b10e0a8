package com.railway.servlet;

import java.io.IOException;
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
        String date = request.getParameter("date"); // We pass this to the results page
        
        // 2. Call DAO
        TrainDAO trainDAO = new TrainDAO();
        List<Train> trainList = trainDAO.searchTrains(source, destination);
        
        // 3. Store results in Request scope
        request.setAttribute("trainList", trainList);
        request.setAttribute("journeyDate", date);
        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        
        // 4. Send to Results Page
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}