package io.tasktrace.tasktrace.entities;

public class TaskCategory {

    private String task_id;
    private Integer category_id;

    public TaskCategory(String task_id, Integer category_id) {
        this.task_id = task_id;
        this.category_id = category_id;
    }

    public String getTask_id() {
        return task_id;
    }

    public void setTask_id(String task_id) {
        this.task_id = task_id;
    }

    public Integer getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Integer category_id) {
        this.category_id = category_id;
    }
}
