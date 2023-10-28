    <%--
      Created by IntelliJ IDEA.
      User: alfredops
      Date: 10/3/23
      Time: 5:46 p.m.
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
        String successMessage = null;
        String errorMessage = null;

        String firstName = null;
        String lastName = null;
        String email = null;

        if(request.getAttribute("firstName") != null
           && request.getAttribute("lastName") != null
           && request.getAttribute("email") != null)
        {
            firstName = (String)request.getAttribute("firstName");
            lastName = (String)request.getAttribute("lastName");
            email = (String)request.getAttribute("email");
        }

        if(request.getAttribute("errorMessage") != null){
            errorMessage = (String) request.getAttribute("errorMessage");
        }

        if(request.getAttribute("successMessage") != null){
            successMessage = (String) request.getAttribute("successMessage");
        }

    %>
    <html>
    <head>
        <meta charset="UTF-8">
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

                let errorMessage = '<%=errorMessage%>';
                let sucessMessage = '<%=successMessage%>';


                if(errorMessage !== 'null') {
                    let toastError = document.getElementById("errorToast");
                    let toast = new bootstrap.Toast(toastError);
                    toast.show();
                }

                if(sucessMessage !== 'null') {
                    let toastSuccess = document.getElementById("successToast");
                    let toast = new bootstrap.Toast(toastSuccess);
                    toast.show();
                }
            }
        </script>

    </head>
    <body class="vh-100">
    <header class="header bg-primary d-flex align-items-center">
        <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
    </header>
    <section class="d-flex flex-column align-items-center mt-4 px-4">
        <h1 class="display-5 text-primary">Sign Up</h1>
        <section id="signupForm">
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-2">
                    <label for="firstName" class="form-label">First Name</label>
                   <%if(firstName == null){%>
                        <input type="text" class="form-control" id="firstName" name="firstName" aria-describedby="nameHelp">
                    <% }else{%>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="<%=firstName%>" aria-describedby="nameHelp">
                    <%}%>
                </div>
                <div class="mb-2">
                    <label for="lastName" class="form-label">Last Name</label>
                    <%if(lastName == null){%>
                        <input type="text" class="form-control" id="lastName" name="lastName" aria-describedby="nameHelp">
                    <% }else{%>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="<%=lastName%>" aria-describedby="nameHelp">
                    <%}%>
                </div>
                <div class="mb-2">
                    <label for="email" class="form-label">Email</label>
                    <%if(email == null){%>
                        <input type="text" class="form-control" id="email" name="email" aria-describedby="nameHelp">
                    <% }else{%>
                        <input type="text" class="form-control" id="email" name="email" value="<%=email%>" aria-describedby="nameHelp">
                    <%}%>
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
                </div>
                <div class="mb-2 form-check mt-4">
                    <input type="checkbox" class="form-check-input" id="termsCheckbox">
                    <label class="form-check-label" for="termsCheckbox">Agree with <a href="${pageContext.request.contextPath}/terms">terms and conditions</a>.</label>
                </div>
                <div class="mt-4 d-sm-inline-flex">
                    <button type="submit" class="btn btn-primary btn-mobile mb-3 p-2">Submit</button>
                    <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary btn-mobile p-2">Return</button></a>
                </div>
            </form>
        </section>
        <section>
            <%if(successMessage != null){%>
                <div class="toast-container position-fixed top-5 end-0 p-3">
                    <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header">
                            <img src="${pageContext.request.contextPath}/resources/images/icons/success.svg" class="rounded me-2 w-5" alt="...">
                            <strong class="me-auto">Success!</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body">
                            <%=successMessage%><br>Go to <a
                                href="${pageContext.request.contextPath}/login" class="text-decoration-none">login</a>
                        </div>
                    </div>
                </div>
            <%}%>
            <%if(errorMessage != null){%>
            <div class="toast-container position-fixed top-5 end-0 p-3">
                <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <img src="${pageContext.request.contextPath}/resources/images/icons/error.svg" class="rounded me-2 w-5" alt="...">
                        <strong class="me-auto">Error!</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">
                        <%=errorMessage%>
                    </div>
                </div>
            </div>
            <%}%>
        </section>
    </section>
    <footer class="position-absolute bottom-0 bg-primary footer d-flex align-items-center justify-content-center w-100">
        <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
    </footer>
    </body>
    </html>
