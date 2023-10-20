<%@ page import="io.tasktrace.tasktrace.entities.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="io.tasktrace.tasktrace.entities.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="io.tasktrace.tasktrace.utils.DateConversionToString" %>
<%@ page import="io.tasktrace.tasktrace.repositories.TaskRepository" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/4/23
  Time: 11:08 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //Defining Initial Variables
    User user = (User)session.getAttribute("loggedUser");
    List<Task> tasks = null;
    String overdue = null;
    String ongoing = null;
    String complete = null;
    int index = 1;

    //Retrieving Data from Request.
    Map<String,Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
    Map<String, List<String>> taskCategory = (Map<String,List<String>>) request.getAttribute("categoryByTask");

    if(request.getAttribute("taskList") != null)
        tasks = (List<Task>) request.getAttribute("taskList");

    //Checking if Stats has value and saving them.
    if(stats != null)
    {
        overdue = String.valueOf(stats.get("overdue"));
        ongoing = String.valueOf(stats.get("ongoing"));
        complete = String.valueOf(stats.get("complete"));
    }
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
    <%if(stats != null){%>
        <div>
            <h4>Overdue</h4>
            <p  class="text-center text-danger fw-bold fs-3"><%=overdue%></p>
        </div>
        <div>
            <h4>Ongoing</h4>
            <p class="text-center fw-bold fs-3"><%=ongoing%></p>
        </div>
        <div>
            <h4 class="">Complete</h4>
            <p class="text-center text-success fw-bold fs-3"><%=complete%></p>
        </div>
    <%}else {%>
    <div>
        <h4>Overdue</h4>
        <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
             alt="Icon that represents an Unknown symbol" class="w-25">
    </div>
    <div>
        <h4>Ongoing</h4>
        <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
             alt="Icon that represents an Unknown symbol" class="w-25">
    </div>
    <div>
        <h4 class="">Complete</h4>
        <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
             alt="Icon that represents an Unknown symbol" class="w-25">
    </div>
    <%}%>
</section>
<section class="dashboard__tasks d-flex flex-column align-items-center mt-10">
    <div style="display: flex; flex-direction: column; width: 85%;">
        <div style="display: flex; justify-content: flex-end;">
            <a href="${pageContext.request.contextPath}/addTask"><button type="button" class="btn btn-outline-primary mb-2">Add Task</button></a>
        </div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Action</th>
                <th scope="col">Title</th>
                <th scope="col">Priority</th>
                <th scope="col">Due Date</th>
                <th scope="col">Category</th>
                <th scope="col">Description</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <%if(tasks != null){ %>
                <%for(Task task: tasks){%>
                    <tr class="">
                        <th scope="row"><%=index++%></th>
                        <td>
                            <div class="d-flex" role="group" aria-label="Basic mixed styles example">
                                <form action="${pageContext.request.contextPath}/dashboard" method="get">
                                    <input type="hidden" name="_method" value="delete">
                                    <input type="hidden" name="task_id" value="<%=task.getId()%>">
                                    <button type="submit" class="btn btn-danger me-3">Delete</button>
                                </form>
                                <%if(!task.getIsDone()){%>
                                    <form action="${pageContext.request.contextPath}/dashboard" method="get">
                                        <input type="hidden" name="_method" value="put">
                                        <input type="hidden" name="action" value="done">
                                        <input type="hidden" name="task_id" value="<%=task.getId()%>">
                                        <button type="submit" class="btn btn-success">Done</button>
                                    </form>
                                <%} else {%>
                                    <form action="${pageContext.request.contextPath}/dashboard" method="get">
                                        <input type="hidden" name="_method Ho" value="put">
                                        <input type="hidden" name="action" value="undo">
                                        <input type="hidden" name="task_id" value="<%=task.getId()%>">
                                        <button type="submit" class="btn btn-warning">Undo</button>
                                    </form>
                                <%}%>
                            </div>
                        </td>
                        <td><%=task.getTitle()%></td>
                        <td><%=task.getPriority()%></td>
                        <td><%=DateConversionToString.getFormattedDate(task.getDueDate(),"MM/dd/yyyy")%></td>
                        <%if(taskCategory != null){%>
                            <td><%=taskCategory.get(task.getId().toString()) %></td>
                        <%}else {%>
                            <td>No category</td>
                        <%}%>
                        <td><%=task.getDescription()%></td>
                    </tr>
                <%}%>
            <%}%>
            </tbody>
        </table>
    </div>
</section>

</body>
</html>
