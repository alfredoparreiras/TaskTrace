package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.Priority;
import io.tasktrace.tasktrace.entities.Task;
import io.tasktrace.tasktrace.entities.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class TaskRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;
    private HttpSession session;

    public TaskRepository(HttpServletRequest request) {
        String databaseName = "tasktrace";
        this.JDBC_URL =  "jdbc:mysql://localhost:3306/" + databaseName;
        this.JDBC_USERNAME = "root";
        this.JDBC_PASSWORD = "19229094";
        this.session = request.getSession(true);
    }

    public List<Task> getTasksByUser(String email) throws ClassNotFoundException , SQLException{
        //Retrieving User from Session
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            User user = (User)session.getAttribute("loggedUser");
            if(user != null)
            {
                String query = "SELECT * FROM tasktrace.Task WHERE user_id=?";

                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, Integer.parseInt(user.getId()));

                List<Task> tasks = new ArrayList<>();
                ResultSet resultSet = statement.executeQuery();

                while(resultSet.next())
                    tasks.add(readNextUser(resultSet));

                if(tasks.size() == 0)
                    return null;
                return tasks;
            }
            return null;
        }
    }

    public Task addTask(Task task) throws ClassNotFoundException , SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            //TODO: Maybe I don't need to get the user here again and get it just when I create my Task Repo.
            User user = (User)session.getAttribute("loggedUser");
            if(user != null){

            String query = "INSERT INTO tasktrace.Task (task_id, title, description, due_date, priority, user_id, created_at, updated_at, is_done) \n" +
                           "VALUES (?,?,?,?,?,?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?);";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,task.getId().toString());
            statement.setString(2, task.getTitle());
            statement.setString(3, task.getDescription());
            statement.setTimestamp(4,Timestamp.valueOf(task.getDueDate()));
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

        return null;
    }

    public void deleteTask(UUID taskId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "DELETE FROM tasktrace.Task WHERE task_id=?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, taskId.toString());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 0)
                throw new SQLException("Failed to Delete Task with ID: " + taskId.toString());
        }
    }

    public boolean updateTask(UUID taskId, Task task) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "UPDATE tasktrace.Task" +
                           "SET title = ?, description = ?, due_date = ?, priority = ?, " +
                           "created_at = ?, updated_at = CURRENT_TIMESTAMP, is_done = ?" +
                           "WHERE id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, task.getTitle());
            statement.setString(2,task.getDescription());
            statement.setTimestamp(3, Timestamp.valueOf(task.getDueDate()));
            statement.setString(4, task.getPriority().toString());
            statement.setTimestamp(5,Timestamp.valueOf(task.getCreatedAt()));
            statement.setBoolean(6, task.getIsDone());
            statement.setString(7,task.getId().toString());


            int rowsAffect = statement.executeUpdate();
            if(rowsAffect > 0)
                return true;

            if(rowsAffect == 0)
                throw new SQLException("Failled to updated Task with ID:" + taskId);
            return false;

        }
    }


    private Task readNextUser(ResultSet resultSet) throws SQLException {
        String id = resultSet.getString("task_id");
        String title = resultSet.getString("title");
        String description = resultSet.getString("description");
        LocalDateTime dueDate = resultSet.getObject("due_date", LocalDateTime.class);
        Priority priority = Priority.valueOf(resultSet.getString("priority"));
        int user_id = resultSet.getInt("user_id");
        LocalDateTime createdAt = resultSet.getObject("created_at", LocalDateTime.class);
        LocalDateTime updatedAt = resultSet.getObject("updated_at", LocalDateTime.class);
        Boolean isDone = resultSet.getBoolean("is_done");


        return new Task(id,title,description,dueDate,priority, user_id,createdAt,updatedAt,isDone );

    }

}
