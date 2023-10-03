<%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/3/23
  Time: 4:11 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>TaskTrace - Login</title>
  <meta  name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex,follow">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
  <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/login.svg" type="image/svg">
</head>
<body class="vh-100">
  <header class="header bg-primary d-flex align-items-center">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
  </header>
<section class="d-flex flex-column align-items-center mt-6">
  <h1 class="display-5 text-primary">Login</h1>
  <form>
    <div class="mb-3">
      <label for="exampleInputEmail1" class="form-label">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
      <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
    </div>
    <div class="row g-3 align-items-center">
      <div class="col-auto">
        <label for="inputPassword6" class="col-form-label">Password</label>
      </div>
      <div class="col-auto">
        <input type="password" id="inputPassword6" class="form-control" aria-describedby="passwordHelpInline">
      </div>
      <div class="col-auto">
    <span id="passwordHelpInline" class="form-text">
      Must be 8-20 characters long.
    </span>
      </div>
    </div>
    <div class="mb-3 form-check mt-4">
      <input type="checkbox" class="form-check-input" id="exampleCheck1">
      <label class="form-check-label" for="exampleCheck1">Save my email</label>
    </div>
    <button type="submit" class="btn btn-primary mt-1">Submit</button>
    <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary mt-1 ms-5">Return</button></a>
  </form>
</section>
<footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
  <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
</footer>

</body>
</html>