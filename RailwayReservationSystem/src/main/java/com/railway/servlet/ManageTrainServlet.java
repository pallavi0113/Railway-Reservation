package com.railway.servlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;
import com.railway.model.Train;

@WebServlet("/ManageTrainServlet")
public class ManageTrainServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TrainDAO dao = new TrainDAO();
        List<Train> list = dao.getAllTrains();
        request.setAttribute("trainList", list);
        request.getRequestDispatcher("manage-trains.jsp").forward(request, response);
    }
}