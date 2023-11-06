package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.TaskCategory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskCategoryRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;

    public TaskCategoryRepository() {
        this.JDBC_URL =  System.getenv("TaskTrace_Database_URL");
        this.JDBC_USERNAME = System.getenv("TaskTrace_DB_User");
        this.JDBC_PASSWORD = System.getenv("TaskTrace_DB_Password");

    }

    public List<TaskCategory> getTaskCategories() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM TaskTrace.TaskCategories";

            PreparedStatement statement = connection.prepareStatement(query);

            List<TaskCategory> taskCategories= new ArrayList<>();

            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
                taskCategories.add(readtNextTaskCategory(resultSet));

            if(taskCategories.isEmpty())
                throw new SQLException("Failed to retrieve Category List by Tasks. ");

            return taskCategories;
        }
    }

    public List<String> getTaskCategoriesByID(String taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT tc.task_id, c.title FROM TaskCategories AS tc INNER JOIN task_trace.Category C on tc.category_id = C.category_id WHERE tc.task_id = ?;";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,taskId);

            List<String> taskCategories= new ArrayList<>();

            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
                taskCategories.add(resultSet.getString("title"));

            if(taskCategories.isEmpty())
                throw new SQLException("Failed to retrieve Category List by Tasks. ");

            return taskCategories;
        }
    }


    public boolean addTaskCategory(TaskCategory taskCategory) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME ,JDBC_PASSWORD))
        {
            String query = "insert into TaskTrace.TaskCategories (task_id, category_id)" +
                           "values (?, ?);";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskCategory.getTask_id());
            statement.setInt(2, taskCategory.getCategory_id());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 0)
                throw new SQLException("Failed to create a TaskCategory row.");

            return rowsAffected > 0;
        }
    }

    private TaskCategory readtNextTaskCategory(ResultSet resultSet) throws SQLException {
        String task_id = resultSet.getString("task_id");
        Integer category_id = resultSet.getInt("category_id");

        return new TaskCategory(task_id, category_id);

    }


}
