<%@ page import="io.tasktrace.tasktrace.entities.User" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/3/23
  Time: 4:11 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%
  String savedEmailCookie = null;
  String message = null;

  if(request.getAttribute("errorMessage") != null)
    message = (String) request.getAttribute("errorMessage");

  Cookie[] cookies = request.getCookies();
  if(cookies != null){
    for(Cookie cookie : cookies){
      if(cookie.getName().equals("saveEmailCookie")){
        savedEmailCookie = cookie.getValue();
        break;
      }
    }
  }
%>
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
  <script>
    window.onload = function () {
      let loginForm = document.getElementById('loginForm');
      let email = document.getElementById('email');
      let password = document.getElementById('password');

      loginForm.addEventListener('submit', function(event) {
        if(!email.value.trim() || !password.value.trim()){
          event.preventDefault();
          alert("Please fill out all required fields.")
        }
      })
    }
  </script>
</head>
<body class="vh-100">
  <header class="header bg-primary d-flex align-items-center">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
  </header>
<section class="d-flex flex-column align-items-center mt-6">
  <h1 class="display-5 text-primary">Login</h1>
  <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
    <div class="mb-3">
      <label for="email" class="form-label">Email address</label>
      <%if(savedEmailCookie != null){%>
        <input type="email" class="form-control" id="email" name="email" value="<%=savedEmailCookie%>" aria-describedby="emailHelp">
      <%} else {%>
        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp">
      <%}%>
      <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
    </div>
    <div class="row g-3 align-items-center">
      <div class="col-auto">
        <label for="password" class="col-form-label">Password</label>
      </div>
      <div class="col-auto">
        <input type="password" id="password" class="form-control" name="password" aria-describedby="passwordHelpInline">
      </div>
      <div class="col-auto">
    <span id="passwordHelpInline" class="form-text">
      Must be 8-20 characters long.
    </span>
      </div>
    </div>
    <div class="mb-3 form-check mt-4">
      <input type="checkbox" class="form-check-input" id="exampleCheck1" name="saveEmailCheckbox">
      <label class="form-check-label" for="exampleCheck1">Save my email</label>
    </div>
    <button type="submit" class="btn btn-primary mt-1">Submit</button>
    <a href="${pageContext.request.contextPath}/home"><button type="button" class="btn btn-outline-secondary mt-1 ms-5">Return</button></a>
  </form>
  <%if(message != null){%>
    <p class="mt-3 text-danger text-center"><%=message%></p>
  <%}%>
</section>
<footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
  <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
</footer>

</body>
</html>
