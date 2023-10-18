package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.Priority;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.User;
import io.tasktrace.tasktrace.repositories.TaskRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.DateTimeException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "AddTaskController", urlPatterns = {"/addTask"})
public class AddTaskController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("WEB-INF/addTask.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieving Data
        String titleParameter = request.getParameter("title");
        String decriptionParameter = request.getParameter("description");
        String dueDateParameter = request.getParameter("dueDate");
        String[] categoriesParameter = request.getParameterValues("categories");
        String priorityParameter = request.getParameter("priority");

        // Retrieving Session
        HttpSession session = request.getSession(true);

        // Local Variables
        LocalDateTime dueDate = null;
        Priority priority = null;
        User loggedUser = (User) session.getAttribute("loggedUser");
        TaskRepository taskRepository = new TaskRepository(request);
        Task taskAdded = null;

        // If user is not available, it's impossible to save a Task. So user need to log in again.
        if(loggedUser == null)
        {
            request.setAttribute("errorMessage", "Please log in to add a task.");
            request.getRequestDispatcher("WEB-INF/login.jsp");
        }

        // Validate this and Parsing ( if necessary ) these Data.
        try
        {
            priority = Priority.valueOf(priorityParameter);
            dueDate = LocalDateTime.parse(dueDateParameter, DateTimeFormatter.ISO_LOCAL_TIME);
        }catch (DateTimeException | IllegalArgumentException e)
        {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed in save your data, please try again.");
        }

        if(titleParameter.isEmpty())
        {
            request.setAttribute("errorMessage", "Please provide a title for your task.");
        }

        // Send information to DB
        try {
            taskAdded = taskRepository.addTask(new Task(titleParameter, decriptionParameter, dueDate, priority, Integer.parseInt(loggedUser.getId())));
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        // Redirect to DashBoard if there is success
        if(taskAdded != null){
            request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);
        }
        // Redirect to AddTask if there is error
            request.getRequestDispatcher("WEB-INF/addTask.jsp").forward(request,response);
    }
}
