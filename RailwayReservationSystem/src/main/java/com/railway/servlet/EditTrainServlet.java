package com.railway.servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;
import com.railway.model.Train;

@WebServlet("/EditTrainServlet")
public class EditTrainServlet extends HttpServlet {
    
    // 1. Show the Edit Form with existing data
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Train t = new TrainDAO().getTrainById(id);
        request.setAttribute("train", t);
        request.getRequestDispatcher("edit-train.jsp").forward(request, response);
    }

    // 2. Save the Updates
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Train t = new Train();
        t.setTrainId(Integer.parseInt(request.getParameter("trainId")));
        t.setTrainName(request.getParameter("trainName"));
        t.setTrainNumber(request.getParameter("trainNumber"));
        t.setSourceStation(request.getParameter("source"));
        t.setDestinationStation(request.getParameter("dest"));
        t.setDepartureTime(request.getParameter("depTime"));
        t.setArrivalTime(request.getParameter("arrTime"));
        t.setTotalSeats(Integer.parseInt(request.getParameter("seats")));
        t.setFare(Double.parseDouble(request.getParameter("fare")));

        new TrainDAO().updateTrain(t);
        response.sendRedirect("ManageTrainServlet");
    }
}