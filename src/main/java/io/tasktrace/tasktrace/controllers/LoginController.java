package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.models.User;
import io.tasktrace.tasktrace.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="LoginServlet", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String saveEmailCheckbox = request.getParameter("saveEmailCheckbox");
        Cookie saveEmailCookie = null;

        UserRepository userRepository = new UserRepository();
        try {
            User user = userRepository.getUserByEmail(email);

            if(user != null && validPassword(user, password)) {
                // If user want to save email for next access we save here through a Cookie.
                if(saveEmailCheckbox != null){
                    saveEmailCookie = new Cookie("saveEmail", user.getEmail());
                    saveEmailCookie.setMaxAge(60 * 60 * 24 * 365 );
                    response.addCookie(saveEmailCookie);
                }
                else
                //TODO: Check if this cookie exists. If extis ok setMaxAge if not jump.
                {
                    saveEmailCookie.setMaxAge(0);
                    response.addCookie(saveEmailCookie);
                }

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
