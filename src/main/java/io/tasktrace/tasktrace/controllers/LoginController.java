package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.models.User;
import io.tasktrace.tasktrace.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserRepository userRepository = new UserRepository();
        try {
            User user = userRepository.getUserByEmail(email);

            if(user != null && validPassword(user, password)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("loggedUser", user);
                request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);
            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception
            e.printStackTrace();
            // Set an error message for the user
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
        }
    }


    private boolean validPassword(User user, String password) {
        if(user.getPassword().equals(password.trim()))
            return true;
        return false;
    }
}
