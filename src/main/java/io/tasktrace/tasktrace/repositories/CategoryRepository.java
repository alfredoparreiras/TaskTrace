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
        this.JDBC_URL =  System.getenv("DATABASE_URL");
        this.JDBC_USERNAME = System.getenv("DATABASE_USER");
        this.JDBC_PASSWORD = System.getenv("DATABASE_PASSWORD");

    }

    public List<Category> getAllCategories() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection connection = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD))
        {
            String query = "SELECT * FROM TaskTrace.Category";

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
            String query = "SELECT * FROM TaskTrace.Category";

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
            String query = "SELECT * FROM TaskTrace.TaskCategories WHERE task_id = ?";

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

            String query = "insert into TaskTrace.Category (title)\n" +
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

            String query = "DELETE from TaskTrace.Category WHERE category_id = ?";

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

    private Category readNextCategory(ResultSet resultSet) throws SQLException {
        int category_id = resultSet.getInt("id");
        String name = resultSet.getString("title");

        return new Category(category_id, name);

    }
}
