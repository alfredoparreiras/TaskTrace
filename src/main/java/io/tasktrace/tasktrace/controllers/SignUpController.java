package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.User;
import io.tasktrace.tasktrace.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name="SignUpController", urlPatterns = {"/signup", "/register"})
public class SignUpController extends HttpServlet {
    //Create new User and Call Repository
    UserRepository userRepository = new UserRepository();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/signup.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        //Creating an Attribute to tell JSP file to display messages;
        request.setAttribute("creatingUser", true);

        //If all data is filled we're going to enter Try-Catch
        try {
            if(validUser(firstName, lastName, email, password, confirmPassword) && validEmail(email, request)) {
                // If Passwords are equal, create the user
                if(validPasswords(password, confirmPassword)) {
                    userRepository.addUser(new User(firstName.toLowerCase().trim(), lastName.toLowerCase().trim(), password.trim(), email.toLowerCase().trim()));
                    request.setAttribute("message", "Your account was successfully created.");
                    request.setAttribute("wasDataFilled", true);
                } else {
                    request.setAttribute("message", "Your password must match.");
                    request.setAttribute("wasDataFilled", true);
                }
            } else {
                request.setAttribute("wasDataFilled", false);
            }
        } catch(SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("WEB-INF/signup.jsp").forward(request,response);
    }

    private boolean validEmail(String email,HttpServletRequest request ) throws SQLException, ClassNotFoundException {
        List<String> emails = userRepository.getAllEmails();
        boolean isEmailPresentInDB = emails.contains(email);
        if(isEmailPresentInDB){
            request.setAttribute("message", "This email already is registered. Please select a new one.");
            return false;
        }
        return true;
    }

    private boolean validUser(String firstName, String lastName, String email, String password, String confirmPassword)
    {
        return !firstName.isEmpty() && !lastName.isEmpty() && !email.isEmpty() && !password.isEmpty() && !confirmPassword.isEmpty();
    }

    private boolean validPasswords(String password, String confirmPassword)
    {
        return password.trim().equals(confirmPassword.trim());
    }


}
