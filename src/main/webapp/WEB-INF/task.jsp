<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: alfredops
  Date: 10/17/23
  Time: 4:16 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String taskId = (String) request.getAttribute("taskId");
    String title = (String) request.getAttribute("title");
    String description = (String) request.getAttribute("description");
    String dueDate = (String) request.getAttribute("dueDate");
    String priority = (String) request.getAttribute("priority");
    Map<String, String> categoryDictionary = (Map<String, String>) request.getAttribute("categories");

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
            let date = new Date(); // gets the current date
            let day = ("0" + date.getDate()).slice(-2); // format day to two digits
            let month = ("0" + (date.getMonth() + 1)).slice(-2); // format month to two digits
            let today = date.getFullYear()+"-"+(month)+"-"+(day) ; // concatenate the year, month and day
            let dueDate = '<%=dueDate%>'
            if(dueDate === 'null')
            {
                document.getElementById("dueDate").value = today; // sets 'today' as the value for 'dueDate'
            }
            else
            {
                document.getElementById("dueDate").value = dueDate
            }

            //Setting Select's Height
            let selectElement = document.getElementById("category");
            selectElement.size = selectElement.options.length;

            let errorMessage = '<%=errorMessage%>'

            if(errorMessage !== 'null'){
                let toastError = document.getElementById('addTaskErrorToast')
                let taskToast = new bootstrap.Toast(toastError)
                taskToast.show()
            }
        }

    </script>
</head>
<body class="d-flex flex-column">
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
<section class="w-75 my-5 mx-auto">
    <h3 class="text-center text-primary mb-5">Task Details</h3>
    <form action="${pageContext.request.contextPath}/task" method="post">
        <input type="hidden" name="_method" value="<%=taskId != null ? "put" : ""%>">
        <input type="hidden" name="taskId" value="<%=taskId != null ? taskId : ""%>">
        <div class="mb-3">
            <input type="text" class="form-control" id="title" placeholder="Title" name="title" value="<%= title != null ? title : "" %>">
            <div id="emailHelp" class="form-text">Must be less than 20 characters.</div>
        </div>
        <div class="">
            <input type="text" class="form-control" id="description" placeholder="Description" name="description" value="<%=description != null ? description : ""%>">
        </div>
        <div class="mt-3">
            <label class="my-2" for="dueDate">Due Date</label>
            <input type="date" class="form-control" id="dueDate" placeholder="Due Date" name="dueDate">
        </div>
       <div class="mt-3">
           <label class="my-2" for="category">Category</label>
           <select class="form-select" aria-label="Default select example" id="category" name="categories" multiple>
               <%if(categoryDictionary != null){ %>
                       <option value="work" <%=categoryDictionary.containsValue("work") ? "selected" : ""%>>Work</option>
                       <option value="personal"<%=categoryDictionary.containsValue("personal") ? "selected" : ""%>>Personal</option>
                       <option value="health&fitness"<%=categoryDictionary.containsValue("health&fitness") ? "selected" : ""%>>Health & Fitness</option>
                       <option value="shopping" <%=categoryDictionary.containsValue("shopping") ? "selected" : ""%>>Shopping</option>
                       <option value="finance" <%=categoryDictionary.containsValue("finance") ? "selected" : ""%>>Finance</option>
                       <option value="social" <%=categoryDictionary.containsValue("social") ? "selected" : ""%>>Social</option>
                       <option value="education" <%=categoryDictionary.containsValue("education") ? "selected" : ""%>>Education</option>
                       <option value="travel" <%=categoryDictionary.containsValue("travel") ? "selected" : ""%>>Travel</option>
                       <option value="hobbies" <%=categoryDictionary.containsValue("hobbies") ? "selected" : ""%>>Hobbies</option>
               <% }else{%>
                   <option value="work">Work</option>
                   <option value="personal">Personal</option>
                   <option value="health&fitness">Health & Fitness</option>
                   <option value="shopping">Shopping</option>
                   <option value="finance">Finance</option>
                   <option value="social">Social</option>
                   <option value="education">Education</option>
                   <option value="travel">Travel</option>
                   <option value="hobbies">Hobbies</option>
               <%}%>
           </select>
           <div id="categoryHelp" class="form-text">You can choose more than one by pressing "cmd" on Mac or "Ctrl" on Windows while clicking the options.</div>
       </div>
        <div class="mt-3">
            <label class="my-2" for="priority">Priority</label>
            <select class="form-select" aria-label="Default select example" id="priority" name="priority">
                <option value="Urgent" <%=priority != null && priority.equals("urgent") ? "selected" : ""%>>Urgent</option>
                <option value="High" <%=priority != null && priority.equals("high") ? "selected" : ""%>>High</option>
                <option value="Medium" <%=priority != null && priority.equals("medium") ? "selected" : ""%>>Medium</option>
                <option value="Low" <%=priority != null && priority.equals("low") ? "selected" : ""%>>Low</option>
            </select>
        </div>
        <div class="d-flex flex-column d-sm-inline-flex justify-content-sm-evenly justify-content-lg-start flex-sm-row gap-3 mt-5 w-100">
            <button type="submit" class="btn btn-primary btn-mobile py-2 px-4">Submit</button>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary">Return</a>
        </div>
    </form>
    <section class="error">
        <%if(errorMessage != null){%>
        <div class="toast-container position-fixed top-5 end-0 p-3">
            <div id="addTaskErrorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icons/error.svg" class="rounded me-2 w-5" alt="...">
                    <strong class="me-auto">Error!</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    <%=errorMessage%>
                </div>
            </div>
        </div>
        <% } %>
    </section>
</section>
</body>
</html>
