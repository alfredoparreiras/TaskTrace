package io.tasktrace.tasktrace.controllers;

import io.tasktrace.tasktrace.entities.Category;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.TaskCategory;
import io.tasktrace.tasktrace.entities.User;
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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name="DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String method = request.getParameter("_method");
        if(method != null && method.equals("delete"))
            doDelete(request,response);
        else if(method != null && method.equals("put"))
            doPut(request,response);
        else
            super.service(request,response);

    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

            // Retrieve tasks and Calculate all Stats
            try {
                HttpSession session = request.getSession(true);
                User user = (User)session.getAttribute("loggedUser");
                TaskRepository taskRepository = new TaskRepository(user);


                String column = "created_at";
                String direction = "ASC";
                boolean isSortingDirection = false;

                if(request.getParameter("column") != null)
                    column= request.getParameter("column");

                if(request.getParameter("direction") != null) {
                    direction = request.getParameter("direction");
                    if(direction.equals("ASC"))
                        request.setAttribute("sortingDirection", false);
                    else
                        request.setAttribute("sortingDirection", true);
                }

                List<Task> tasks = taskRepository.getAllTasksByOrder(column, direction);

                //Convert a List<Category> into a Map.
                Map<Integer, String> categoryMap = getCategoriesMap();
                //Process this List with a List of Categories by Task and create a Map with a TaskID and List of Categories.
                Map<String, List<String>> categoriesByTask = getCategoriesByTask(categoryMap);

                if(categoriesByTask != null)
                    request.setAttribute("categoryByTask", categoriesByTask);

                // Calculate Overall stats, if it are overdue, complete or ongoing.
                if(tasks != null && !tasks.isEmpty())
                {
                    request.setAttribute("taskList", tasks);
                    Map<String, Integer> stats = calculateTasksStats(tasks);
                    request.setAttribute("stats",stats);
                }

                request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);

            } catch (ClassNotFoundException | SQLException e) {
                request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request,response);
                throw new RuntimeException(e);
            }
    }
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        try {
            HttpSession session = request.getSession(true);

            User user = (User)session.getAttribute("loggedUser");

            String action = request.getParameter("action");
            String taskId = request.getParameter("task_id");

            TaskRepository taskRepository = new TaskRepository(user);
            Task task = taskRepository.getTaskById(taskId);

            boolean isActionFinish = false;

            if(action.equals("complete") && !task.getIsDone())
            {
                task.setIsDone(true);
                isActionFinish = taskRepository.updateTask(taskId, task);
            }
            if(action.equals("reset") && task.getIsDone())
            {
                task.setIsDone(false);
                isActionFinish = taskRepository.updateTask(taskId, task);
            }
            if(!isActionFinish)
                request.setAttribute("errorMessage", "Something got wrong in update Task Status.");
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException
    {

        try {
            HttpSession session = request.getSession(true);
            User user = (User)session.getAttribute("loggedUser");
            String taskId = request.getParameter("task_id");
            TaskRepository taskRepository = new TaskRepository(user);
            taskRepository.deleteTask(taskId);
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (ClassNotFoundException | SQLException e) {
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
            if(!task.getIsDone() && LocalDate.now().isAfter(task.getDueDate()))
            {
                overdue++;
            }

            if(!task.getIsDone() && !LocalDate.now().isAfter(task.getDueDate()) ) {
                ongoing++;
            }

            if(task.getIsDone())
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
    private Map<Integer, String> getCategoriesMap() throws SQLException, ClassNotFoundException
    {
        CategoryRepository categoryRepository = new CategoryRepository();
        List<Category> categoryList = categoryRepository.getAllCategories();
        Map<Integer, String> categoryMap = new HashMap<>();
        for(Category category : categoryList)
            categoryMap.put(category.getId(), category.getCategory());

        if(categoryMap.isEmpty())
            //TODO: don't return null in case of a collection. Its better to return empty.
            return null;
        return categoryMap;
    }
    private Map<String, List<String>> getCategoriesByTask(Map<Integer,String> categoryMap) throws SQLException, ClassNotFoundException
    {
        TaskCategoryRepository taskCategoryRepository = new TaskCategoryRepository();
        List<TaskCategory> allTaskCategories = taskCategoryRepository.getTaskCategories();

        Map<String, List<String>> categoryByTask = new HashMap<>();

        for(TaskCategory taskCategory : allTaskCategories){
            if(categoryMap.containsKey(taskCategory.getCategory_id())) {
                if(categoryByTask.containsKey(taskCategory.getTask_id()))
                {
                    List<String> categories = categoryByTask.get(taskCategory.getTask_id());
                    categories.add(categoryMap.get(taskCategory.getCategory_id()));
                }
                else
                {
                    List<String> categories = new ArrayList<>();
                    categoryByTask.put(taskCategory.getTask_id(), categories );
                    categories.add(categoryMap.get(taskCategory.getCategory_id()));
                }
            }
        }

        if(!categoryByTask.isEmpty())
            return categoryByTask;
        return null;

    }
}
