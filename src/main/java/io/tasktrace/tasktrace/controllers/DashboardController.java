package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.User;
import io.tasktrace.tasktrace.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try{
            UserRepository userRepository = new UserRepository();
            User loggedUser = userRepository.getUserByEmail("a.alfredops@gmail.com");

            //Retrieving a Session
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUser", loggedUser);

            // Retrieve tasks

            // Calculate Stats

            // Store information

            // Redirect the route

            request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
