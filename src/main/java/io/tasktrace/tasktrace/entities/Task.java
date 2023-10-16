package io.tasktrace.tasktrace.entities;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

public class Task {
    private final UUID id;
    private String title;
    private String description;
    private LocalDateTime dueDate;
    private Priority priority;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean isDone;


    //Constructors


    public Task(String name, String description, LocalDateTime dueDate, Priority priority, LocalDateTime createdAt, LocalDateTime updatedAt, Boolean isDone) {
        this.id = UUID.randomUUID();
        this.title = Objects.requireNonNull(name, "Name cannot be null.");
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isDone = false;
    }

    public Task(String id, String name, String description, LocalDateTime dueDate, Priority priority, LocalDateTime createdAt, LocalDateTime updatedAt, Boolean isDone) {
        this.id = UUID.fromString(id);
        this.title = Objects.requireNonNull(name, "Name cannot be null.");
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isDone = false;
    }

    public Task(Task task){
        this(task.getId().toString(), task.getTitle(), task.getDescription(),task.getDueDate(), task.getPriority(), task.getCreatedAt(), task.getUpdatedAt(), task.getIsDone());
    }


    // Getters
    public UUID getId() {
        return id;
    }
    public String getTitle() {
        return title;
    }
    public Priority getPriority() {
        return priority;
    }
    public LocalDateTime getDueDate() {
        return dueDate;
    }
    public Boolean getIsDone(){return isDone;};
    public String getDescription() {
        return description;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }


    // Setters
    public void setTitle(String title) {
        this.title = Objects.requireNonNull(title, "Name cannot be null.");
    }
    public void setPriority(Priority priority) {
        this.priority = priority;
    }
    public void setDueDate(LocalDateTime dueDate) {
        this.dueDate = dueDate;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setIsDone(Boolean status){
        this.isDone = status;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Methods
    public Boolean doTask(){
        if(getIsDone() == false)
        {
            setIsDone(true);
            return true;
        }
        return false;

    }
}
