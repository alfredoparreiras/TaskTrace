    <%--
      Created by IntelliJ IDEA.
      User: alfredops
      Date: 10/3/23
      Time: 5:46 p.m.
      To change this template use File | Settings | File Templates.
    --%>

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
        <meta  name="description" content="TaskTrace it is a productive hub where you can easily manage all your tasks">
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
        <section id="signupForm">
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-2">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" aria-describedby="nameHelp">
                </div>
                <div class="mb-2">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" aria-describedby="nameHelp">
                </div>
                <div class="mb-2">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" aria-describedby="nameHelp">
                </div>
                <div class="mb-2">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                    <div class="form-text">
                        Your password must be 8-20 characters long, contain letters and numbers, and must not contain spaces or emoji.
                    </div>
                </div>
                <div class="mb-2">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                    <div  class="form-text">
                        Your password must be 8-20 characters long, contain letters and numbers, and must not contain spaces or emoji.
                    </div>
                </div>
                <div class="mb-2 form-check mt-4">
                    <input type="checkbox" class="form-check-input" id="termsCheckbox">
                    <label class="form-check-label" for="termsCheckbox">Agree with <a href="${pageContext.request.contextPath}/terms">terms and conditions</a>.</label>
                </div>
                <div class="mt-4">
                    <button type="submit" class="btn btn-primary me-3">Submit</button>
                    <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary">Return</button></a>
                </div>
            </form>
        </section>
        <section class="mt-5">
            <%if(creatingUser){ %>
            <%if(message != null && message.equals("Your account was successfully created.")){%>
            <div class="alert alert-success" role="alert"><%=message%><br>Go to <a
                    href="${pageContext.request.contextPath}/login" class="text-decoration-none">login</a>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%} else if(message != null){%>
            <div class="alert alert-danger" role="alert">
                <%=message%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } else if(!wasDataFilled){%>
            <div class="alert alert-danger" role="alert">
                You must fill all fields
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }else {%>
            <div class="alert alert-danger" role="alert">
                <%=message%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%}%>
            <%}%>
        </section>
    </section>
    <footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
        <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
    </footer>

    </body>
    </html>
