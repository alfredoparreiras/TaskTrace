package io.tasktrace.tasktrace.models;

import java.util.List;
import java.util.Objects;
import java.util.UUID;

public class User {
    private final String id;
    private String firstName;
    private String lastName;
    private String password;
    private String email;


    //Constructors
    public User(String id, String firstName, String lastName, String password, String email) {
        this.id = Objects.requireNonNull(id);
        this.firstName = Objects.requireNonNull(firstName);
        this.lastName = Objects.requireNonNull(lastName);
        this.password = Objects.requireNonNull(password);
        this.email = Objects.requireNonNull(email);
    }

    public User(String firstName, String lastName, String password, String email) {
        this.id = "0";
        this.firstName = Objects.requireNonNull(firstName);
        this.lastName = Objects.requireNonNull(lastName);
        this.password = Objects.requireNonNull(password);
        this.email = Objects.requireNonNull(email);
    }

    public User(String id, User user) {
        this.id = id;
        this.firstName = user.getFirstName();
        this.lastName = user.getLastName();
        this.password = user.getPassword();
        this.email = user.getEmail();
    }


    //GETTERS
    public String getId() {
        return id;
    }

    public String getFullName(){
        return firstName + " " + lastName;
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
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setEmail(String email) {
        this.email = email;
    }


    // METHODS
    //TODO: Should I create this method here?
    public Boolean verifyLogin(){
        return true;
    }
}
