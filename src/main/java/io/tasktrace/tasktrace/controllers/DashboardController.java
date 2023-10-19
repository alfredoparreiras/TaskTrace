package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.Category;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.TaskCategory;
import io.tasktrace.tasktrace.entities.User;
import io.tasktrace.tasktrace.repositories.CategoryRepository;
import io.tasktrace.tasktrace.repositories.TaskCategoryRepository;
import io.tasktrace.tasktrace.repositories.TaskRepository;
import io.tasktrace.tasktrace.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name="DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try{
            HttpSession session = request.getSession(true);
            UserRepository userRepository = new UserRepository();
            User loggedUser =(User) session.getAttribute("loggedUser");
            List<Task> tasks = null;

            if(loggedUser != null){
                // Retrieve tasks
                TaskRepository taskRepository = new TaskRepository(loggedUser);
                tasks = taskRepository.getAllTasks();
                request.setAttribute("allTasks", tasks);
            }

            //TODO: Need to improve this.

            Map<Integer, String> categoryMap = getCategoriesMap();
            Map<String, List<String>> categoriesByTask = getCategoriesByTask(categoryMap);
            if(categoriesByTask != null)
                request.setAttribute("categoryByTask", categoriesByTask);

            // Calculate Stats
            if(tasks != null && !tasks.isEmpty())
            {
                Map<String, Integer> stats = calculateTasksStats(tasks);
                if(stats != null)
                    request.setAttribute("stats",stats);
                else
                    request.setAttribute("errorMessage", "An error has occurred during the calculation of the statistics." +
                                                " Please check your data or try again later.");
            }

            // Redirect the route
            request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private Map<String, Integer> calculateTasksStats(List<Task> tasks)
    {
        int overdue = 0;
        int ongoing = 0;
        int complete = 0;

        for(Task task : tasks)
        {
            if(task.getIsDone() == false && task.getDueDate().isAfter(LocalDate.now()))
            {
                overdue++;
            }

            if(task.getIsDone() == false && task.getDueDate().isBefore(LocalDate.now()))
            {
                ongoing++;
            }

            if(task.getIsDone() == true)
            {
                complete++;
            }
        }

        Map<String, Integer> stats = new HashMap<>();
        stats.put("overdue", overdue);
        stats.put("ongoing", ongoing);
        stats.put("complete", complete);

        return stats;
    }

    private Map<Integer, String> getCategoriesMap() throws SQLException, ClassNotFoundException {
        CategoryRepository categoryRepository = new CategoryRepository();
        List<Category> categoryList = categoryRepository.getAllCategories();
        Map<Integer, String> categoryMap = new HashMap<>();
        for(Category category : categoryList)
            categoryMap.put(category.getId(), category.getCategory());

        if(categoryMap.isEmpty())
            return null;
        return categoryMap;
    }

    private Map<String, List<String>> getCategoriesByTask(Map<Integer,String> categoryMap) throws SQLException, ClassNotFoundException {
        TaskCategoryRepository taskCategoryRepository = new TaskCategoryRepository();
        List<TaskCategory> allTaskCategories = taskCategoryRepository.getTaskCategories();

        Map<String, List<String>> categoryByTask = new HashMap<>();
        for(TaskCategory taskCategory : allTaskCategories)
            if(categoryMap.containsKey(taskCategory.getCategory_id())) {

                List<String> categories = new ArrayList<>();
                categories.add(categoryMap.get(taskCategory.getCategory_id()));
                categoryByTask.put(taskCategory.getTask_id(), categories );
            }
        if(!categoryByTask.isEmpty())
            return categoryByTask;
        return null;

    }

}
