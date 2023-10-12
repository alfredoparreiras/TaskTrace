    <%--
      Created by IntelliJ IDEA.
      User: alfredops
      Date: 10/3/23
      Time: 5:46 p.m.
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
        boolean wasDataFilled = false;
        boolean creatingUser = false;
        String message = null;


        if(request.getAttribute("message") != null){
            message = (String) request.getAttribute("message");
        }
        if(request.getAttribute("wasDataFilled") != null){
            wasDataFilled = (boolean) request.getAttribute("wasDataFilled");
        }
        if(request.getAttribute("creatingUser") != null){
            creatingUser = (boolean) request.getAttribute("creatingUser");
        }

    %>
    <html>
    <head>
        <title>TaskTrace - Signup</title>
        <meta  name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="noindex,follow">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
        <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/signup.svg" type="image/svg">
        <script>
            window.onload = function () {
                let checkbox = document.getElementById('termsCheckbox');
                let signupForm = document.getElementById('signupForm');

                signupForm.addEventListener('submit', function (event) {
                    if (!checkbox.checked) {
                        event.preventDefault();
                        alert("Please agree to the terms and conditions.");
                    }
                });
            }
        </script>

    </head>
    <body class="vh-100">
    <header class="header bg-primary d-flex align-items-center">
        <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
    </header>
    <section class="d-flex flex-column align-items-center mt-4">
        <h1 class="display-5 text-primary">Sign Up</h1>
        <form id="signupForm" class="w-25" action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" aria-describedby="nameHelp">
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" aria-describedby="nameHelp">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" aria-describedby="nameHelp">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password">
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
            </div>
            <div class="mb-3 form-check mt-4">
                <input type="checkbox" class="form-check-input" id="termsCheckbox">
                <label class="form-check-label" for="termsCheckbox">Agree with <a href="${pageContext.request.contextPath}/terms">terms and conditions</a>.</label>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
            <%if(creatingUser){ %>
                <%if(message != null && message.equals("Your account was successfully created.")){%>
                    <p class="text-success mt-3 text-center"><%=message%><br>Go to <a
                            href="${pageContext.request.contextPath}/login" class="text-decoration-none">login</a></p>
                <%} else if(message != null && !message.equals("Your account was successfully created.")){%>
                    <p class="text-danger mt-3 text-center"><%=message%></p>
                <% } else if(!wasDataFilled){%>
                    <p class="text-danger mt-3 text-center">You must fill all fields</p>
                <% }else {%>
                    <p class="text-danger mt-3 text-center"><%=message%></p>
                <%}%>
            <%}%>
<%--            TODO: Set as center this botton.--%>
            <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary mt-1 ms-5">Return</button></a>
        </form>
    </section>
    <footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
        <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
    </footer>

    </body>
    </html>
