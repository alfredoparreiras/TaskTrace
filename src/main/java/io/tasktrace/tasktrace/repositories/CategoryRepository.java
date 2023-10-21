package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.Category;
import jakarta.servlet.http.HttpServletRequest;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.*;

public class CategoryRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;

    public CategoryRepository() {
        String databaseName = "tasktrace";
        this.JDBC_URL =  "jdbc:mysql://localhost:3306/" + databaseName;
        this.JDBC_USERNAME = "root";
        this.JDBC_PASSWORD = "19229094";

    }

    public List<Category> getAllCategories() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM Category";

            PreparedStatement statement = connection.prepareStatement(query);
            List<Category> categories= new ArrayList<>();

            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next())
                categories.add(readNextCategory(resultSet));

            return categories;
        }
    }

    public Map<Integer,String> mapCategories() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM Category";

            PreparedStatement statement = connection.prepareStatement(query);
            Map<Integer,String> categories = new HashMap<>();

            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next())
            {
                Category category = readNextCategory(resultSet);
                categories.put(category.getId(),category.getCategory());
            }

            return categories;
        }
    }

    public List<Category> getCategoriesByTask(UUID task_id) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM tasktrace.TaskCategory WHERE task_id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,task_id.toString());

            List<Category> categories= new ArrayList<>();

            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
                categories.add(readNextCategory(resultSet));

            if(categories.isEmpty())
                throw new SQLException("Failed to retrieve Category List by Tasks. ");

            return null;
        }
    }

    public Category addCategory(String categoryName) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {

            String query = "insert into Category (name)\n" +
                           "values (?);";

            PreparedStatement statement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,categoryName);

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
                return new Category(getGeneratedId(statement), categoryName);

            if(rowsAffected == 0)
                throw new SQLException("Failed in Add Category to DB.");

            return null;
        }
    }

    private Integer getGeneratedId(PreparedStatement statement) throws SQLException
    {
        try(ResultSet generatedKeys = statement.getGeneratedKeys())
        {
            if(generatedKeys.next())
                return generatedKeys.getInt(1);
            throw new SQLException("The category was created, but the generated ID could not be read.");
        }
    }

    public boolean deleteCategory(int categoryId) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {

            String query = "DELETE from tasktrace.Category WHERE category_id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,categoryId);

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
                return true;

            if(rowsAffected == 0)
                throw new SQLException("Failed in Delete Category.");

            return false;
        }
    }

    public boolean updateCategory(Category category) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {

            String query = "UPDATE Category" +
                           "SET name = ?" +
                           "WHERE category_id = ?";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,category.getCategory());
            statement.setInt(2, category.getId());

            int rowsAffected = statement.executeUpdate();
            if(rowsAffected > 0)
                return true;

            if(rowsAffected == 0)
                throw new SQLException("Failed in update Category to DB.");

            return false;
        }
    }


    private Category readNextCategory(ResultSet resultSet) throws SQLException {
        int category_id = resultSet.getInt("category_id");
        String name = resultSet.getString("name");

        return new Category(category_id, name);

    }
}
