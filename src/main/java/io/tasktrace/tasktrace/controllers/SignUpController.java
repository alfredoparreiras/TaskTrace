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
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@WebServlet(name="SignUpController", urlPatterns = {"/signup", "/register"})
public class SignUpController extends HttpServlet {
    String emailValidationMessage = null;
    String passwordValidationMessage = null;
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
        //TODO: Do I need this?
        //request.setAttribute("creatingUser", true);

        try
        {
            //Check if all fields are filled.
            if(isDataFilled(firstName, lastName, email, password, confirmPassword))
            {
                request.setAttribute("wasDataFilled", true);

                if(!validEmail(email))
                {
                    request.setAttribute("errorMessage", emailValidationMessage);
                    return;
                }

                if(validPassword(password, confirmPassword))
                {
                    userRepository.addUser(new User(firstName.toLowerCase().trim(), lastName.toLowerCase().trim(),
                            password.trim(), email.toLowerCase().trim()));
                    request.setAttribute("successMessage", "Your account was successfully created.");
                }
                else
                {
                    request.setAttribute("errorMessage", passwordValidationMessage);
                    request.setAttribute("firstName",firstName);
                    request.setAttribute("lastName",lastName);
                    request.setAttribute("email",email);
                }
            }
            else
            {
                request.setAttribute("errorMessage", "You must fill all fields. ");
            }
        }
        catch(SQLException | ClassNotFoundException e)
        {
            // Log the exception
            e.printStackTrace();
        }
        finally
        {
        request.getRequestDispatcher("WEB-INF/signup.jsp").forward(request,response);
        }
    }

    private boolean isDataFilled(String firstName, String lastName, String email, String password, String confirmPassword)
    {
        return !firstName.isEmpty() && !lastName.isEmpty() && !email.isEmpty() && !password.isEmpty() && !confirmPassword.isEmpty();
    }


    private boolean validPassword(String password, String confirmPassword){
        boolean isPasswordFormated = checkPasswordFormat(password);
        boolean arePasswordsEquals = checkIfPasswordsAreEqual(password, confirmPassword);

        if(!isPasswordFormated)
            passwordValidationMessage = "Your password must be between 8-20 characters, and should have" +
                    "at least 1 letter, 1 number and 1 special character.";
        if(!arePasswordsEquals)
            passwordValidationMessage = "Your password must match.";

        return isPasswordFormated && arePasswordsEquals;
    }

    private boolean validEmail(String email ) throws SQLException, ClassNotFoundException {
        boolean isEmailInUse = isEmailAlreadyInUse(email);
        boolean isEmailFormatted = isEmailFormatted(email);
        if(isEmailInUse)
            emailValidationMessage = "This email is already in use. Please type another one.";

        if(!isEmailFormatted)
            emailValidationMessage = "This is not a valid email. Please type a valid one.";

        return isEmailFormatted && !isEmailInUse;
    }

    //TODO: What way of organize this code is better? This way or spliting by "functions" in my method.
    private boolean isEmailFormatted(String email) {
        String regex = "\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private boolean isEmailAlreadyInUse(String email) throws ClassNotFoundException, SQLException {
        List<String> emails = userRepository.getAllEmails();
        return emails.contains(email);
    }
    private boolean checkPasswordFormat(String password)
    {
        String regex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=!]).{8,20}$";

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);

        return matcher.matches();
    }

    private boolean checkIfPasswordsAreEqual(String password, String confirmPassword)
    {
        return password.equals(confirmPassword);
    }


}
