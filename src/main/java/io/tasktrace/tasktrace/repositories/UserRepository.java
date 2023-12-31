package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.User;
import io.tasktrace.tasktrace.utils.PasswordUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;

    public UserRepository() {
        this.JDBC_URL =  System.getenv("DATABASE_URL");
        this.JDBC_USERNAME = System.getenv("DATABASE_USER");
        this.JDBC_PASSWORD = System.getenv("DATABASE_PASSWORD");
    }

    public User getUserByEmail(String email) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "SELECT * FROM TaskTrace.User WHERE email=?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next())
                return readNextUser(resultSet);

            return null;
        }
    }

    public List<String> getAllEmails() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT email FROM TaskTrace.User;";

            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            List<String> emails = new ArrayList<>();

            while(resultSet.next()){
                String email = resultSet.getString("email");
                emails.add(email);
            }

            return emails;
        }
    }

    public User addUser(User user) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD))
        {
            String query = "INSERT INTO TaskTrace.User (first_name, last_name, password, email, created_at) \n" +
                           "VALUES (?,?,?,?, CURRENT_TIMESTAMP);";

            PreparedStatement statement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, PasswordUtil.hashPassword(user.getPassword()));
            statement.setString(4, user.getEmail());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
            {
                return new User(getGeneratedId(statement), user);
            }
            else {
                throw new SQLException("Failled to create an User.");
            }
        }
    }

    private Integer getGeneratedId(PreparedStatement statement) throws SQLException
    {
        try(ResultSet generatedKeys = statement.getGeneratedKeys())
        {
            if(generatedKeys.next())
                return generatedKeys.getInt(1);
            throw new SQLException("The user was created, but the generated ID could not be read.");
        }
    }

    private User readNextUser(ResultSet resultSet) throws SQLException {
        Integer id = resultSet.getInt("id");
        String firstName = resultSet.getString("first_name");
        String lastName = resultSet.getString("last_name");
        String password = resultSet.getString("password");
        String email = resultSet.getNString("email");

        return new User(id, firstName,lastName,password,email);
    }
}


