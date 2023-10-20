package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.Priority;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.User;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class TaskRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;
    private final User user;

    public TaskRepository(User user) {
        String databaseName = "tasktrace";
        this.JDBC_URL =  "jdbc:mysql://localhost:3306/" + databaseName;
        this.JDBC_USERNAME = "root";
        this.JDBC_PASSWORD = "19229094";
        this.user = Objects.requireNonNull(user, "User must be logged.");
    }

    public List<Task> getAllTasks() throws ClassNotFoundException , SQLException{
        //Retrieving User from Session
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
                String query = "SELECT * FROM tasktrace.Task WHERE user_id=? " +
                               "ORDER BY created_at ASC";

                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, Integer.parseInt(user.getId()));

                List<Task> tasks = new ArrayList<>();
                ResultSet resultSet = statement.executeQuery();
                while(resultSet.next())
                    tasks.add(readNextTask(resultSet));

                if(tasks.size() == 0)
                    return null;
                return tasks;
        }
    }
    public Task getTaskById(String taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM tasktrace.Task WHERE task_id=? ";

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
            String query = "INSERT INTO tasktrace.Task (task_id, title, description, due_date, priority, user_id, created_at, updated_at, is_done) \n" +
                           "VALUES (?,?,?,?,?,?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?);";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,task.getId().toString());
            statement.setString(2, task.getTitle());
            statement.setString(3, task.getDescription());
            statement.setDate(4,Date.valueOf(task.getDueDate()));
            statement.setString(5, task.getPriority().toString());
            statement.setInt(6,Integer.parseInt(user.getId()));
            statement.setBoolean(7, task.getIsDone());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
                return new Task(task);
            else
                throw new SQLException("Failled to create a Task");
        }
    }
    public void deleteTask(String taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "DELETE FROM tasktrace.Task WHERE task_id=?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskId);

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 0)
                throw new SQLException("Failed to Delete Task with ID: " + taskId.toString());
        }
    }
    public boolean updateTask(Task task) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "UPDATE tasktrace.Task " +
                           "SET title = ?, description = ?, due_date = ?, priority = ?, " +
                           "created_at = ?, updated_at = CURRENT_TIMESTAMP, is_done = ? " +
                           "WHERE task_id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, task.getTitle());
            statement.setString(2,task.getDescription());
            statement.setDate(3, Date.valueOf(task.getDueDate()));
            statement.setString(4, task.getPriority().toString());
            statement.setTimestamp(5,Timestamp.valueOf(task.getCreatedAt()));
            statement.setBoolean(6, task.getIsDone());
            statement.setString(7,task.getId().toString());


            int rowsAffect = statement.executeUpdate();
            if(rowsAffect > 0)
                return true;

            if(rowsAffect == 0)
                throw new SQLException("Failled to updated Task with ID:" + task.getId().toString());
            return false;

        }
    }


    private Task readNextTask(ResultSet resultSet) throws SQLException {
        String id = resultSet.getString("task_id");
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
