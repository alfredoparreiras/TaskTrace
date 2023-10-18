package io.tasktrace.tasktrace.repositories;

import io.tasktrace.tasktrace.entities.Category;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepository {
    private final String JDBC_URL;
    private final String JDBC_USERNAME;
    private final String JDBC_PASSWORD;

    public CategoryRepository(HttpServletRequest request) {
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
            String query = "SELECT * FROM tasktrace.Category";

            PreparedStatement statement = connection.prepareStatement(query);
            List<Category> categories= new ArrayList<>();

            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
                categories.add(ReadNextCategory(resultSet));

            if(categories.isEmpty())
                throw new SQLException("Failed to retrieve Category List. ");

            return null;
        }
    }

    public boolean addCategory(String categoryName) throws ClassNotFoundException, SQLException
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
                return true;

            if(rowsAffected == 0)
                throw new SQLException("Failed in Add Category to DB.");

            return false;
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

    private Category ReadNextCategory(ResultSet resultSet) throws SQLException {
        int category_id = resultSet.getInt("category_id");
        String name = resultSet.getString("name");

        return new Category(category_id, name);

    }
}
