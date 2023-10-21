<%@ page import="io.tasktrace.tasktrace.entities.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="io.tasktrace.tasktrace.entities.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="io.tasktrace.tasktrace.utils.DateConversionToString" %>
<%@ page import="io.tasktrace.tasktrace.repositories.TaskRepository" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="io.tasktrace.tasktrace.utils.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/4/23
  Time: 11:08 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //Defining Initial Variables
    User user = (User) session.getAttribute("loggedUser");
    List<Task> tasks = null;
    String overdue = null;
    String ongoing = null;
    String complete = null;
    String pendingTasks = null;
    int index = 1;
    int mobileIndex = 1;

    //Retrieving Data from Request.
    Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
    Map<String, List<String>> taskCategory = (Map<String, List<String>>) request.getAttribute("categoryByTask");

    if (request.getAttribute("taskList") != null)
        tasks = (List<Task>) request.getAttribute("taskList");

    //Checking if Stats has value and saving them.
    if (stats != null) {
        overdue = String.valueOf(stats.get("overdue"));
        ongoing = String.valueOf(stats.get("ongoing"));
        complete = String.valueOf(stats.get("complete"));
        pendingTasks = String.valueOf(stats.get("overdue") + stats.get("ongoing"));
    }
%>

<html>
<head>
    <title>TaskTrace - Dashboard</title>
    <meta name="description" content="TaskTrace it is a productive hub where you can easly manage all your tasks">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex,follow">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/icons/dashboard.svg" type="image/svg">
</head>
<body>
<header class="header bg-primary d-flex align-items-center justify-content-between w-100">
    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
        <p class="text-white fs-5 pt-3 ps-3">TaskTrace</p>
    </a>
    <img src="${pageContext.request.contextPath}/resources/images/icons/account.svg" alt="account icon"
         class="icon me-3">
</header>
<section class="dashboard__tasks d-flex flex-column align-items-center mt-5 mt-sm-5 mt-md-5 mt-lg-5">
    <div style="display: flex; flex-direction: column; width: 85%;" class="mb-5">
        <h2>Hello <span class="text-capitalize"><%=user.getFirstName()%></span>,<br> You have <%=pendingTasks%> pending task(s).</h2>
    </div>
    <%if (stats != null) {%>
    <div class="d-flex align-items-center justify-content-between w-35">
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4>Overdue</h4>
            <p class="text-center text-danger fw-bold fs-3"><%=overdue%>
            </p>
        </div>
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4>Ongoing</h4>
            <p class="text-center fw-bold fs-3"><%=ongoing%>
            </p>
        </div>
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4 class="">Complete</h4>
            <p class="text-center text-success fw-bold fs-3"><%=complete%>
            </p>
        </div>
    </div>
    <%} else {%>
    <div class="d-flex align-items-center justify-content-evenly w-25">
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h4>Overdue</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-25">
        </div>
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h4>Ongoing</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-25">
        </div>
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h4 class="">Complete</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-25">
        </div>
    </div>
    <%}%>
    <div class="d-flex flex-column w-85 mt-4">
        <div style="display: flex; justify-content: flex-end;">
            <a href="${pageContext.request.contextPath}/addTask">
                <button type="button" class="btn btn-outline-primary mb-2">Add Task</button>
            </a>
        </div>
        <table class="table table-hover large_screen_layout ">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Action</th>
                <th scope="col">Title</th>
                <th scope="col">Description</th>
                <th scope="col">Priority</th>
                <th scope="col">Category</th>
                <th scope="col">Due Date</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <%if (tasks != null) { %>
                <%for (Task task : tasks) {%>
                <%--If Task is complete we must change the row style.--%>
                <%if (task.getIsDone()) {%>
                <tr class="text-decoration-line-through">
                    <th class="align-middle" scope="row"><%=index++%>
                    </th>
                    <td class="align-middle">
                        <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
                            <form action="${pageContext.request.contextPath}/dashboard" method="get">
                                <input type="hidden" name="_method" value="delete">
                                <input type="hidden" name="task_id" value="<%=task.getId()%>">
                                <button type="submit" class="btn btn-danger me-3">Delete</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/dashboard" method="get">
                                <input type="hidden" name="_method" value="put">
                                <input type="hidden" name="action" value="undo">
                                <input type="hidden" name="task_id" value="<%=task.getId()%>">
                                <button type="submit" class="btn btn-warning">Undo</button>
                            </form>
                        </div>
                    </td>
                    <td class="align-middle"><%=task.getTitle()%></td>
                    <td class="align-middle"><%=task.getDescription()%></td>
                    <%if (task.getPriority().toString().equals("URGENT") || task.getPriority().toString().equals("HIGH")) {%>
                        <td class="text-danger align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%></td>
                    <%} else {%>
                        <td class="align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%></td>
                    <%}%>
                    <%if (taskCategory != null) {%>
                    <%
                        List<String> displayCategories = taskCategory.get(task.getId());
                    %>
                        <%if (displayCategories != null) {%>
                            <td class="align-middle">
                                <%for (String category : displayCategories) {%>
                                    <span><%=category + " "%></span>
                                <%}%>
                            </td>
                        <%} else {%>
                            <td class="align-middle">No category</td>
                        <%}%>
                    <%}%>
                    <td class="align-middle"><%=DateConversionToString.getFormattedDate(task.getDueDate(), "EEE, dd MMM yyyy")%></td>
                </tr>
            <%} else {%>
            <tr class="">
                <th class="align-middle" scope="row"><%=index++%>
                </th>
                <td class="align-middle">
                    <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
                        <form action="${pageContext.request.contextPath}/dashboard" method="get">
                            <input type="hidden" name="_method" value="delete">
                            <input type="hidden" name="task_id" value="<%=task.getId()%>">
                            <button type="submit" class="btn btn-danger me-3">Delete</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/dashboard" method="get">
                            <input type="hidden" name="_method" value="put">
                            <input type="hidden" name="action" value="done">
                            <input type="hidden" name="task_id" value="<%=task.getId()%>">
                            <button type="submit" class="btn btn-success">Done</button>
                        </form>
                    </div>
                </td>
                <td class="align-middle" class=""><%=task.getTitle()%>
                </td>
                <td class="align-middle"><%=task.getDescription()%>
                </td>
                <%if (task.getPriority().toString().equals("URGENT") || task.getPriority().toString().equals("HIGH")) {%>
                <td class="text-danger align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%>
                </td>
                <%} else {%>
                <td class="align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%>
                </td>
                <%}%>
                <%if (taskCategory != null) {%>
                <%
                    List<String> displayCategories = taskCategory.get(task.getId());
                %>
                <%if (displayCategories != null) {%>
                <td class="align-middle">
                    <%for (String category : displayCategories) {%>
                    <span><%=category + " "%></span>
                    <%}%>
                </td>
                <%} else {%>
                <td class="align-middle">No category</td>
                <%}%>
                <%}%>
                <td class="align-middle"><%=DateConversionToString.getFormattedDate(task.getDueDate(), "EEE, dd MMM yyyy")%>
                </td>
            </tr>
            <%}%>
            <%}%>
            <%}%>
            </tbody>
        </table>
        <%@ include file="xsDashboardLayout.jsp" %>
    </div>
</section>
</body>
</html>
