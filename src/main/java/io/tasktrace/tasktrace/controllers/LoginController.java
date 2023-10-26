package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.User;
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

        //Retrieving Cookies
        Cookie[] cookies = request.getCookies();
        Cookie saveEmailCookie = getCookies(cookies, "saveEmailCookie");

        UserRepository userRepository = new UserRepository();
        try {
            User user = userRepository.getUserByEmail(email);

            if(user == null)
                request.setAttribute("errorMessage", "The user associated with this email does not exist.");

            if(user != null) {
                // If user want to save email for next access we save here through a Cookie.
                if(saveEmailCheckbox != null){
                    saveEmailCookie = new Cookie("saveEmailCookie", user.getEmail());
                    saveEmailCookie.setMaxAge(60 * 60 * 24 * 365 );
                    response.addCookie(saveEmailCookie);
                }

                if(saveEmailCheckbox == null && saveEmailCookie != null){
                    saveEmailCookie.setMaxAge(0);
                    response.addCookie(saveEmailCookie);
                }

                if(!validPassword(user,password)){
                    request.setAttribute("errorMessage", "Invalid password");
                    request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
                }
                else
                {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("loggedUser", user);
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                    return; //Terminate the method here, so it does not try to forward
                }
            }
            else
            {
                request.setAttribute("errorMessage", "The user associated with this email does not exist.");
                request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
            }

            request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception
            e.printStackTrace();
            // Set an error message for the user
            request.setAttribute("errorMessage", "An internal error occurred. Please try again later.");
            request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
        }
    }

    private Cookie getCookies(Cookie[] cookies, String cookieName) {

        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals(cookieName)){
                    return cookie;
                }
            }
        }
        return null;
    }


    private boolean validPassword(User user, String password) {
        return user.getPassword().equals(password.trim());
    }
}
