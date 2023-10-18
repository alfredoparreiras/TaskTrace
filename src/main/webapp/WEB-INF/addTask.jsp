<%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/17/23
  Time: 4:16 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TaskTrace - Add Task</title>
    <meta  name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex,follow">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/addTask.svg" type="image/svg">
    <script>
        window.onload = function() {
            var date = new Date(); // gets the current date
            var day = ("0" + date.getDate()).slice(-2); // format day to two digits
            var month = ("0" + (date.getMonth() + 1)).slice(-2); // format month to two digits
            var today = date.getFullYear()+"-"+(month)+"-"+(day) ; // concatenate the year, month and day

            document.getElementById("dueDate").value = today; // sets 'today' as the value for 'dueDate'
        }
    </script>
</head>
<body class="d-flex flex-column">
<header class="header bg-primary d-flex align-items-center justify-content-between">
    <a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">
        <p class="text-white fs-5 pt-3 ps-2">TaskTrace</p>
    </a>
    <img src="${pageContext.request.contextPath}/resources/images/icons/account.svg" alt="account icon" class="icon me-3">
</header>
<section class="w-75 my-5 mx-auto">
    <h3 class="text-center text-primary mb-5">Add a Task</h3>
    <form action="${pageContext.request.contextPath}/addTask" method="post">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="title" placeholder="Title" name="title">
            <label for="title">Title</label>
        </div>
        <div class="form-floating">
            <input type="text" class="form-control" id="description" placeholder="Description" name="description">
            <label for="description">Description</label>
        </div>
        <div class="form-floating mt-3">
            <input type="date" class="form-control" id="dueDate" placeholder="Due Date" name="dueDate">
            <label for="dueDate">Due Date</label>
        </div>
        <div class="form-floating mt-3">
            <select class="form-select" aria-label="Default select example" id="category" name="categories" multiple>
                <option value="1">High</option>
                <option value="2">Medium</option>
                <option value="3">Low</option>
            </select>
            <label for="category">Category</label>
        </div>
        <div class="form-floating mt-3">
            <select class="form-select" aria-label="Default select example" id="priority" name="priority">
                <option value="1">First</option>
                <option value="2">Two</option>
                <option value="3">Three</option>
            </select>
            <label for="priority">Priority</label>
        </div>
        <div>
            <button type="submit" class="btn btn-primary mt-5 me-3">Submit</button>
            <a href="${pageContext.request.contextPath}/dashboard"><button type="button" class="btn btn-outline-secondary mt-5">Return</button></a>
        </div>
    </form>

</section>

</body>
</html>
