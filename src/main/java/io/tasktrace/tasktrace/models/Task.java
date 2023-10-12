package io.tasktrace.tasktrace.models;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

public class Task {
    private final UUID id;
    private String name;
    private Priority priority;
    private LocalDateTime dueDate;
    private List<Category> listOfCategories;
    private String description;


    //Constructors
    public Task(UUID id, String name, Priority priority, LocalDateTime dueDate, List<Category> listOfCategories, String description) {
        this.id = Objects.requireNonNull(id);
        this.name = Objects.requireNonNull(name);
        this.priority = Objects.requireNonNull(priority);
        this.dueDate = Objects.requireNonNull(dueDate);
        this.listOfCategories = Objects.requireNonNull(listOfCategories);
        this.description = Objects.requireNonNull(description);
    }

    // Getters

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Priority getPriority() {
        return priority;
    }

    public LocalDateTime getDueDate() {
        return dueDate;
    }

    public List<Category> getListOfCategories() {
        return listOfCategories;
    }

    public String getDescription() {
        return description;
    }

    // Setters

    public void setName(String name) {
        this.name = name;
    }

    public void setPriority(Priority priority) {
        this.priority = priority;
    }

    public void setDueDate(LocalDateTime dueDate) {
        this.dueDate = dueDate;
    }

    public void setListOfCategories(List<Category> listOfCategories) {
        this.listOfCategories = listOfCategories;
    }

    public void setDescription(String description) {
        description = description;
    }
}
