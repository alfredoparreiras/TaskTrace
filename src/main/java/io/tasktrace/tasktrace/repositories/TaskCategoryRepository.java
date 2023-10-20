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
        String databaseName = "tasktrace";
        this.JDBC_URL =  "jdbc:mysql://localhost:3306/" + databaseName;
        this.JDBC_USERNAME = "root";
        this.JDBC_PASSWORD = "19229094";

    }

    public List<TaskCategory> getTaskCategories() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM tasktrace.TaskCategory";

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

    public boolean addTaskCategory(TaskCategory taskCategory) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME ,JDBC_PASSWORD))
        {
            String query = "insert into TaskCategory (task_id, category_id)" +
                           "values (?, ?);";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskCategory.getTask_id());
            statement.setInt(2, taskCategory.getCategory_id());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 0)
                throw new SQLException("Failed to create a TaskCategory row.");
            if(rowsAffected > 0)
                return true;

            return false;
        }
    }

    private TaskCategory readtNextTaskCategory(ResultSet resultSet) throws SQLException {
        String task_id = resultSet.getString("task_id");
        Integer category_id = resultSet.getInt("category_id");

        return new TaskCategory(task_id, category_id);

    }


}
