<%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/17/23
  Time: 4:16 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
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
            //Setting  Date as Today.
            var date = new Date(); // gets the current date
            var day = ("0" + date.getDate()).slice(-2); // format day to two digits
            var month = ("0" + (date.getMonth() + 1)).slice(-2); // format month to two digits
            var today = date.getFullYear()+"-"+(month)+"-"+(day) ; // concatenate the year, month and day
            document.getElementById("dueDate").value = today; // sets 'today' as the value for 'dueDate'

            //Setting Select's Height
            var selectElement = document.getElementById("category");
            var numberOfOptions = selectElement.options.length;

            selectElement.size = numberOfOptions;
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
        <label class="my-2" for="category">Category</label>
        <select class="form-select" aria-label="Default select example" id="category" name="categories" multiple>
            <option value="work">Work</option>
            <option value="personal">Personal</option>
            <option value="health&fitness">Health & Fitness</option>
            <option value="shopping">Shopping</option>
            <option value="finance">Finance</option>
            <option value="social">Social</option>
            <option value="education">Education</option>
            <option value="travel">Travel</option>
            <option value="hobbies">Hobbies</option>
        </select>
        <div class="form-floating mt-3">
            <select class="form-select" aria-label="Default select example" id="priority" name="priority">
                <option value="Urgent">Urgent</option>
                <option value="High">High</option>
                <option value="Medium">Medium</option>
                <option value="Low">Low</option>
            </select>
            <label for="priority">Priority</label>
        </div>
        <div>
            <button type="submit" class="btn btn-primary mt-5 me-3">Submit</button>
            <a href="${pageContext.request.contextPath}/dashboard"><button type="button" class="btn btn-outline-secondary mt-5">Return</button></a>
        </div>
    </form>
    <section class="error">
        <%if(errorMessage != null){%>
            <p class="text-center text-danger text-capitalize"><%=errorMessage%></p>
        <% } %>
    </section>

</section>

</body>
</html>
