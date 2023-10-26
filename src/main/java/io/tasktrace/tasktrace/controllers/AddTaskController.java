package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.*;
import io.tasktrace.tasktrace.repositories.CategoryRepository;
import io.tasktrace.tasktrace.repositories.TaskCategoryRepository;
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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddTaskController", urlPatterns = {"/addTask"})
public class AddTaskController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("WEB-INF/addTask.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieving Data from Request
            String titleParameter = request.getParameter("title");
            String decriptionParameter = request.getParameter("description");
            String dueDateParameter = request.getParameter("dueDate");
            String[] categoriesParameter = request.getParameterValues("categories");
            String priorityParameter = request.getParameter("priority");

            // Retrieving Session
            HttpSession session = request.getSession(true);

            // Local Variables
            User loggedUser = (User) session.getAttribute("loggedUser");
            Task taskAdded;
            Category categoryAdded = null;
            boolean isAllValid = false;
            boolean preValidation = true;

            //Repositories
            TaskRepository taskRepository = new TaskRepository(loggedUser);
            TaskCategoryRepository taskCategoryRepository = new TaskCategoryRepository();
            CategoryRepository categoryRepository = new CategoryRepository();

            // Validate this and Parsing ( if necessary ) these Data.
            LocalDate dueDate = parsingDueDate(dueDateParameter, request);
            Priority priority = parsingPriority(priorityParameter, request);
            // If user is not available, it's impossible to save a Task. So user need to log in again.

            ArrayList<Task> existingTasks = new ArrayList<>(taskRepository.getAllTasks());

            for(Task task : existingTasks){
                if(task.getTitle().equals(titleParameter)){
                    request.setAttribute("errorMessage","It looks like you already have a task named this. " +
                            "Please enter a different name for your new task.");
                    preValidation = false;
                }
            }


            if(validateAction(request, loggedUser, titleParameter) && (dueDate != null && priority != null) && preValidation)
            {

                // If all data is good, is going to save this task into DB.
                taskAdded = taskRepository.addTask(new Task(titleParameter, decriptionParameter, dueDate, priority, loggedUser.getId(), false));

                // Retrieve all categories and check if this category already exists in DB.
                Map<Integer,String> allCategoriesFromDB = categoryRepository.mapCategories();
                for(String categoryParameter : categoriesParameter)
                {
                    if(!allCategoriesFromDB.containsValue(categoryParameter))
                        categoryAdded = categoryRepository.addCategory(categoryParameter);

                    Integer keyForCategory = null;
                    for (Map.Entry<Integer, String> entry : allCategoriesFromDB.entrySet()) {
                        if (entry.getValue().equals(categoryParameter)) {
                            keyForCategory = entry.getKey();
                            break;
                        }
                    }

                    // If task and category were properly created, we save this these two into TaskCategory DB ( many-to-many relationship )
                    if(taskAdded != null)
                        isAllValid = taskCategoryRepository.addTaskCategory(new TaskCategory(taskAdded.getId().toString(), keyForCategory));
                    else
                        request.setAttribute("errorMessage","Task creation failed. Please try again.");
                }
            }

            if(isAllValid)
            {
                // Redirect to DashBoard if there is success
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
            else
            {
                request.getRequestDispatcher("WEB-INF/addTask.jsp").forward(request,response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    private LocalDate parsingDueDate(String date, HttpServletRequest request)
    {
        try{
            return LocalDate.parse(date.trim(), DateTimeFormatter.ISO_LOCAL_DATE);
        }catch (DateTimeException e)
        {
            request.setAttribute("errorMessage", "Failed to save Due Date. Try again.");
            return null;
        }
    }

    private Priority parsingPriority(String priority, HttpServletRequest request)
    {
        try{
            return Priority.valueOf(priority.toUpperCase());

        }catch (IllegalArgumentException e)
        {
            request.setAttribute("errorMessage", "Failed to priority. Try again.");
            return null;
        }
    }

    private boolean validateAction(HttpServletRequest request, User loggedUser, String titleParameter) {
        if(loggedUser == null)
        {
            request.setAttribute("errorMessage", "Please log in to add a task.");
            return false;
        }

        if(titleParameter.isEmpty())
        {
            request.setAttribute("errorMessage", "Please provide a title for your task.");
            return false;
        }
        return true;

    }
}
