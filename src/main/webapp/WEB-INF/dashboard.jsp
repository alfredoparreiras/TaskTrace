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
    String pendingTasks = "0";
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

    <script>
        function redirectToTask(taskId) {
            let url = '${pageContext.request.contextPath}/task?taskId=' + taskId;
            window.location.href = url;
        }
    </script>
</head>
<body>
<header class="header bg-primary d-flex align-items-center justify-content-between w-100">
    <div class="d-flex">
        <a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none d-flex align-items-center">
            <img src="${pageContext.request.contextPath}/resources/images/Logo.png"  class="w-5">
            <p class="text-white fs-5 m-0">TaskTrace</p>
        </a>
    </div>
    <a href="${pageContext.request.contextPath}/login"
       onclick="return confirm('Are you sure you want to logout?');">
        <img src="${pageContext.request.contextPath}/resources/images/icons/logout.svg"
             alt="account icon"
             class="icon me-3">
    </a>
</header>
<section class="dashboard__tasks d-flex flex-column align-items-center mt-5 mt-sm-5 mt-md-5 mt-lg-5">
    <div class="d-flex flex-column w-85 mb-5 justify-content-center">
        <h2>Hello <span class="text-capitalize"><%=user.getFirstName()%></span>,<br> You have <span class="border-bottom border-1 border-dark"><%=pendingTasks%></span> pending <%=pendingTasks.equals("0") ? "task" : "tasks"%>.</h2>
        <%@ include file="dashboarStats.jsp" %>
        <%@ include file="dashboardContent.jsp" %>
    </div>
</section>
</body>
</html>
