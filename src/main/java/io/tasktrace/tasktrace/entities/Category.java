package io.tasktrace.tasktrace.entities;

import java.util.Objects;

public class Category {
    private final Integer id;
    private String category;

    // Constructors
    public Category(Integer id, String category) {
        this.id = Objects.requireNonNull(id);
        this.category = Objects.requireNonNull(category, "Category cannot be null");
    }

    public Category(Integer id, Category category) {
        this.id = Objects.requireNonNull(id);
        this.category = category.getCategory();
    }

    public Category(String category) {
        this.id = 0;
        this.category = Objects.requireNonNull(category, "Category cannot be null.");
    }


    // Getters
    public Integer getId() {
        return id;
    }

    public String getCategory() {
        return category;
    }

    // Setters
    public void setCategory(String category){
        this.category = Objects.requireNonNull(category, "Category cannot be null.");
    }
}
