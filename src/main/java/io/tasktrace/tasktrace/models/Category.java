package io.tasktrace.tasktrace.models;

import java.util.Objects;
import java.util.UUID;

public class Category {
    private final UUID id;
    private String category;

    // Constructors
    public Category(UUID id, String category) {
        this.id = Objects.requireNonNull(id);
        this.category = Objects.requireNonNull(category);
    }

    // Getters
    public UUID getId() {
        return id;
    }

    public String getCategory() {
        return category;
    }
}
