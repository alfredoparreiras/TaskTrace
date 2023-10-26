package io.tasktrace.tasktrace.entities;

import java.util.Objects;

public class User {
    private final Integer id;
    private final String firstName;
    private final String lastName;
    private String password;
    private String email;

    //Constructors
    public User(Integer id, String firstName, String lastName, String password, String email) {
        this.id = Objects.requireNonNull(id);
        this.firstName = Objects.requireNonNull(firstName);
        this.lastName = Objects.requireNonNull(lastName);
        this.password = Objects.requireNonNull(password);
        this.email = Objects.requireNonNull(email);
    }
    public User(String firstName, String lastName, String password, String email) {
        this.id = 0;
        this.firstName = Objects.requireNonNull(firstName);
        this.lastName = Objects.requireNonNull(lastName);
        this.password = Objects.requireNonNull(password);
        this.email = Objects.requireNonNull(email);
    }
    public User(Integer id, User user) {
        this.id = id;
        this.firstName = user.getFirstName();
        this.lastName = user.getLastName();
        this.password = user.getPassword();
        this.email = user.getEmail();
    }

    //GETTERS
    public Integer getId() {
        return id;
    }
    public String getFirstName() {
        return firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public String getPassword() {
        return password;
    }
    public String getEmail() {
        return email;
    }

    // SETTERS
    public void setPassword(String password) {
        this.password = password;
    }
    public void setEmail(String email) {
        this.email = email;
    }
}

