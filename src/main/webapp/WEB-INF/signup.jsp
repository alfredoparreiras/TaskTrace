<%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/3/23
  Time: 5:46 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TaskTrace - Signup</title>
    <meta  name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex,follow">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/signup.svg.svg" type="image/svg">
</head>
<body class="vh-100">
<header class="header bg-primary d-flex align-items-center">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
</header>
<section class="d-flex flex-column align-items-center mt-6">
    <h1 class="display-5 text-primary">Sign Up</h1>
    <form class="w-25">
        <div class="mb-3">
            <label for="nameInput" class="form-label">Name</label>
            <input type="text" class="form-control" id="nameInput" aria-describedby="nameHelp">
        </div>
        <div class="mb-3">
            <label for="emailInput" class="form-label">Email</label>
            <input type="email" class="form-control" id="emailInput" aria-describedby="nameHelp">
        </div>
        <div class="mb-3">
            <label for="passwordInput" class="form-label">Password</label>
            <input type="password" class="form-control" id="passwordInput">
        </div>
        <div class="mb-3">
            <label for="confirmPasswordInput" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="confirmPasswordInput">
        </div>
        <div class="mb-3 form-check mt-4">
            <input type="checkbox" class="form-check-input" id="exampleCheck1">
            <label class="form-check-label" for="exampleCheck1">Agree with <a href="/terms">terms and conditions</a>.</label>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
        <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary mt-1 ms-5">Return</button></a>

    </form>
</section>
<footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
    <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
</footer>

</body>
</html>
