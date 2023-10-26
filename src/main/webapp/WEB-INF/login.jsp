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

      let message = '<%= message %>';

      if (message !== 'null') {
        let toastEl = document.getElementById('errorToast');
        let toast = new bootstrap.Toast(toastEl);

        toast.show();
      }

    }
  </script>
</head>
<body class="vh-100">
  <header class="header bg-primary d-flex align-items-center">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><p class="text-white fs-5 pt-3 ps-2">TaskTrace</p></a>
  </header>
<section class="d-flex flex-column align-items-center mt-4">
  <h1 class="display-5 text-primary">Login</h1>
  <section class="py-5 px-3 " id="loginForm">
    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="mb-3">
        <label for="email" class="form-label">Email address</label>
        <%if(savedEmailCookie != null){%>
        <input type="email" class="form-control" id="email" name="email" value="<%=savedEmailCookie%>" aria-describedby="emailHelp">
        <%} else {%>
        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp">
        <%}%>
        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
      </div>
      <div>
        <label for="password" class="form-label">Password</label>
        <input type="password" id="password" class="form-control" name="password" aria-describedby="passwordHelpInline">
      </div>
      <%if(savedEmailCookie != null){%>
      <div class="mb-3 form-check mt-4">
        <input type="checkbox" class="form-check-input" id="saveEmailChecked" name="saveEmailCheckbox" checked>
        <label class="form-check-label" for="saveEmailChecked">Remember email next time?</label>
      </div>
      <%} else {%>
      <div class="mb-3 form-check mt-4">
        <input type="checkbox" class="form-check-input" id="saveEmail" name="saveEmailCheckbox" >
        <label class="form-check-label" for="saveEmail">Remember email next time?</label>
      </div>
      <%}%>
      <section class="mt-1">
        <button type="submit" class="btn btn-primary me-3">Submit</button>
        <a href="${pageContext.request.contextPath}/home">
          <button type="button" class="btn btn-outline-secondary">Return</button>
        </a>
      </section>
    </form>
  </section>
  <%if(message != null){%>
  <div class="toast-container position-fixed top-3 end-0 p-3">
    <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header">
        <img src="${pageContext.request.contextPath}/resources/images/icons/error.svg" class="rounded me-2 w-5" alt="...">
        <strong class="me-auto">Error</strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div class="toast-body">
        <%=message%>
      </div>
    </div>
  </div>
  <%}%>
</section>
<footer class="fixed-bottom bg-primary footer d-flex align-items-center justify-content-center">
  <p class="text-white text-center fs-5 pt-3">TaskTrace © 2023</p>
</footer>

</body>
</html>
