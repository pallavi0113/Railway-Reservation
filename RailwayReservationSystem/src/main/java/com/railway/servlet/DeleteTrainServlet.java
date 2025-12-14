package com.railway.servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.railway.dao.TrainDAO;

@WebServlet("/DeleteTrainServlet")
public class DeleteTrainServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        new TrainDAO().deleteTrain(id);
        response.sendRedirect("ManageTrainServlet"); // Refresh list
    }
}