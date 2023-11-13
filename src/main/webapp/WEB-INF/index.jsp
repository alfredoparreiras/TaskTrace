<%@ page import="io.tasktrace.tasktrace.utils.PasswordUtil" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/2/23
  Time: 4:34 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>TaskTrace</title>
    <meta  name="description" content="TaskTrace it is a productive hub where you can easily manage all your tasks">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex,follow">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/tasks.svg" type="image/svg">
</head>
<body class="bg-light d-flex flex-column justify-content-center align-items-center min-vh-100 ">
<div data-aos="fade-down" data-aos-duration="1500" class="d-flex flex-column flex-sm-row align-items-center justify-content-sm-center initial__logo mt-2 mt-sm-0">
    <img src="${pageContext.request.contextPath}/resources/images/new-logo.png" class="w-15" alt="">
    <h1 class="initial__heading text-primary test mb-3">TaskTrace</h1>
</div>
<h3 data-aos="fade-down" data-aos-duration="1500" class="text-primary sub__heading text-center mx-3">Bridging the gap between <span class="fw-bolder accent">To-Do</span> and <span class="fw-bolder accent">Done</span>.</h3>
<div data-aos="fade-up" data-aos-duration="1500" class="d-flex flex-column d-sm-inline-flex justify-content-sm-center flex-sm-row gap-3 my-5 w-75">
    <a href="${pageContext.request.contextPath}/signup" class="text-decoration-none">
        <button type="button" class="btn btn-primary btn-mobile btn-lg text-white initial__button btn-sign p-2">Sign Up</button>
    </a>
    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
        <button type="button" class="btn btn-primary btn-mobile btn-lg text-white initial__button btn-sign p-2">Log In</button>
    </a>
</div>
<footer class="w-100 large--footer">
    <p class="text-primary text-center fs-5">TaskTrace © 2023</p>
</footer>
</body>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
    AOS.init();
</script>
</html>