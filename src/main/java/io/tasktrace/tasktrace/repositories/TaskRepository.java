package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.Priority;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.User;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class TaskRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;
    private final User user;

    public TaskRepository(User user) {
        this.JDBC_URL =  System.getenv("DATABASE_URL");
        this.JDBC_USERNAME = System.getenv("DATABASE_USER");
        this.JDBC_PASSWORD = System.getenv("DATABASE_PASSWORD");
        this.user = Objects.requireNonNull(user, "User must be logged.");
    }

    public List<Task> getAllTasks() throws ClassNotFoundException , SQLException{
        //Retrieving User from Session
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
                String query = "SELECT * FROM TaskTrace.Task WHERE user_id=? " +
                               "ORDER BY created_at ASC ";

                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, user.getId());

                List<Task> tasks = new ArrayList<>();
                ResultSet resultSet = statement.executeQuery();
                while(resultSet.next())
                    tasks.add(readNextTask(resultSet));
                return tasks;
        }
    }

    public List<Task> getAllTasksByOrder(String column, String direction) throws ClassNotFoundException , SQLException{

        List<String> validColumns = Arrays.asList("title","description","due_date", "priority", "created_at");
        List<String> validDirections = Arrays.asList("ASC", "DESC");

        if(!validColumns.contains(column) || !validDirections.contains(direction))
            throw new IllegalArgumentException("Invalid Column name or Sorting Direction");
        //Retrieving User from Session
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM TaskTrace.Task WHERE user_id=? ORDER BY " + column + " " + direction + ";";


            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, user.getId());

            List<Task> tasks = new ArrayList<>();
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
                tasks.add(readNextTask(resultSet));
            return tasks;
        }
    }


    public Task getTaskById(String taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM TaskTrace.Task WHERE id=? ";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskId);

            Task task = null;
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next())
                task = new Task(readNextTask(resultSet));

            if(task == null)
                throw new SQLException("Failed in retrieve Task from DB");

            return task;
        }
    }
    public Task addTask(Task task) throws ClassNotFoundException , SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "INSERT INTO TaskTrace.Task (id, title, description, due_date, priority, user_id, created_at, updated_at, is_done) \n" +
                           "VALUES (?,?,?,?,?,?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?);";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,task.getId().toString());
            statement.setString(2, task.getTitle());
            statement.setString(3, task.getDescription());
            statement.setDate(4,Date.valueOf(task.getDueDate()));
            statement.setString(5, task.getPriority().toString());
            statement.setInt(6,(user.getId()));
            statement.setBoolean(7, task.getIsDone());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
                return new Task(task);
            else
                throw new SQLException("Failed to create a Task");
        }
    }
    public void deleteTask(String taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "DELETE FROM TaskTrace.Task WHERE id=?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskId);

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 0)
                throw new SQLException("Failed to Delete Task with ID: " + taskId);
        }
    }
    public boolean updateTask(String taskId, Task task) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "UPDATE TaskTrace.Task " +
                           "SET title = ?, description = ?, due_date = ?, priority = ?, " +
                           "updated_at = CURRENT_TIMESTAMP, is_done = ? " +
                           "WHERE id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, task.getTitle());
            statement.setString(2,task.getDescription());
            statement.setDate(3, Date.valueOf(task.getDueDate()));
            statement.setString(4, task.getPriority().toString());
            statement.setBoolean(5, task.getIsDone());
            statement.setString(6,taskId);


            int rowsAffect = statement.executeUpdate();
            if(rowsAffect > 0)
                return true;

            if(rowsAffect == 0)
                throw new SQLException("Failed to updated Task with ID:" + task.getId().toString());
            return false;

        }
    }


    private Task readNextTask(ResultSet resultSet) throws SQLException {
        String id = resultSet.getString("id");
        String title = resultSet.getString("title");
        String description = resultSet.getString("description");
        LocalDate dueDate = resultSet.getObject("due_date", LocalDate.class);
        Priority priority = Priority.valueOf(resultSet.getString("priority"));
        int user_id = resultSet.getInt("user_id");
        LocalDateTime createdAt = resultSet.getObject("created_at", LocalDateTime.class);
        LocalDateTime updatedAt = resultSet.getObject("updated_at", LocalDateTime.class);
        Boolean isDone = resultSet.getBoolean("is_done");

        return new Task(id,title,description,dueDate,priority, user_id,createdAt,updatedAt,isDone );

    }

}
