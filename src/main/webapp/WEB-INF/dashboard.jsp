<%@ page import="io.tasktrace.tasktrace.entities.User" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/4/23
  Time: 11:08 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User)session.getAttribute("loggedUser");
%>

<html>
<head>
    <title>TaskTrace - Dashboard</title>
    <meta  name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex,follow">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/dashboard.svg" type="image/svg">
</head>
<body>
<header class="header bg-primary d-flex align-items-center justify-content-between">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
        <p class="text-white fs-5 pt-3 ps-2">TaskTrace</p>
    </a>
    <%if(user != null){%>
        <p class="text-white fs-4 pt-3 ps-2">Welcome, <%=user.getFirstName()%></p>
    <%}%>
    <img src="${pageContext.request.contextPath}/resources/images/icons/account.svg" alt="account icon" class="icon me-3">
</header>
<section class="dashboard__resume d-flex align-items-center justify-content-evenly mt-5">
    <div>
        <h4>Overdue</h4>
        <p  class="text-center text-danger fw-bold fs-3">7</p>
    </div>
    <div>
        <h4>Ongoing</h4>
        <p class="text-center fw-bold fs-3">7</p>
    </div>
    <div>
        <h4 class="">Complete</h4>
        <p class="text-center text-success fw-bold fs-3">7</p>
    </div>
</section>
<section class="dashboard__tasks d-flex flex-column align-items-center mt-10">
    <div style="display: flex; flex-direction: column; width: 85%;">
        <div style="display: flex; justify-content: flex-end;">
            <button type="button" class="btn btn-outline-primary mb-2">Add Task</button>
        </div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Action</th>
                <th scope="col">Name</th>
                <th scope="col">Priority</th>
                <th scope="col">Due Date</th>
                <th scope="col">Category</th>
                <th scope="col">Description</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <tr class="">
                <th scope="row">1</th>
                <td>
                    <div class="btn-group-sm" role="group" aria-label="Basic mixed styles example">
                        <button type="button" class="btn btn-danger">Delete</button>
                        <button type="button" class="btn btn-success">Complete</button>
                    </div>
                </td>
                <td>Finish this Project</td>
                <td>High</td>
                <td>10/06/2023</td>
                <td>Work</td>
                <td>Got a Job</td>
            </tr>
            </tbody>
        </table>
    </div>
</section>

</body>
</html>
