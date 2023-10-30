<div class="large_screen_layout align-self-center mt-5 w-100">
  <div class="d-flex flex-column my-1">
    <div style="display: flex; justify-content: flex-end;">
      <a href="${pageContext.request.contextPath}/addTask">
        <button type="button" class="btn btn-outline-primary mb-2">Add Task</button>
      </a>
    </div>
    <table class="table table-hover">
      <thead>
      <tr>
        <th scope="col">Id</th>
        <th scope="col">Action</th>
        <th scope="col">Title</th>
        <th scope="col">Description</th>
        <th scope="col">Priority</th>
        <th scope="col">Category</th>
        <th scope="col">Due Date</th>
        <th scope="col"></th>
      </tr>
      </thead>
      <tbody class="table-group-divider">
      <%if (tasks != null) { %>
      <%for (Task task : tasks) {
        boolean done = task.getIsDone();
      %>
      <%--If Task is complete we must change the row style.--%>
      <tr class="<%=done ? "text-decoration-line-through" : "" %>">
        <%--TASK INDEX--%>
        <th class="align-middle" scope="row"><%=index++%></th>
        <%--TASK BUTTONS--%>
        <td class="align-middle">
          <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
              <form action="${pageContext.request.contextPath}/dashboard" method="get">
                <input type="hidden" name="_method" value="put">
                <input type="hidden" name="action" value="<%= done ? "reset" : "complete"%>">
                <input type="hidden" name="task_id" value="<%=task.getId()%>">
                <button type="submit" class="btn <%=done ? "btn-warning" : "btn-success"%> w-100">
                  <%=done ? "Reset" : "Complete"%>
                </button>
              </form>
          </div>
        </td>
        <%--TASK TITLE--%>
        <td class="align-middle"><%=task.getTitle()%></td>
        <%--TASK DESCRIPTION--%>
        <td class="align-middle"><%=task.getDescription()%></td>
        <%--TASK PRIORITY--%>
        <%if (task.getPriority().toString().equals("URGENT") || task.getPriority().toString().equals("HIGH")) {%>
        <td class="text-danger align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%></td>
        <%} else {%>
        <td class="align-middle"><%=StringUtils.toCapitalCase(task.getPriority().toString())%></td>
        <%}%>
        <%--TASK CATEGORIES--%>
        <%if (taskCategory != null) {%>
        <%
          List<String> displayCategories = new ArrayList<>();
          displayCategories = taskCategory.get(task.getId().toString());
        %>
        <%if (displayCategories != null) {%>
        <td class="align-middle">
          <%for (String category : displayCategories) {%>
          <span><%=StringUtils.toCapitalCase(category) + " "%></span>
          <%}%>
        </td>
        <%} else {%>
        <td class="align-middle">No category</td>
        <%}%>
        <%}%>
        <%--TASK DESCRIPTION--%>
        <td class="align-middle"><%=DateConversionToString.getFormattedDate(task.getDueDate(), "EEE, dd MMM yyyy")%></td>
        <td class="align-middle">
          <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
            <form action="${pageContext.request.contextPath}/dashboard" method="get">
              <input type="hidden" name="_method" value="delete">
              <input type="hidden" name="task_id" value="<%=task.getId()%>">
              <button type="submit" class="btn btn-danger w-100 me-3"
                      onclick="return confirm('This action cannot be undone. Are you sure you want to delete this task?');">Delete</button>
            </form>
          </div>
        </td>
      </tr>
      <%}%>
      <%}%>
      </tbody>
    </table>
  </div>
</div>


<div class="small_screen_layout">
    <a href="${pageContext.request.contextPath}/addTask" class="p-1">
      <button type="button" class="btn btn-primary w-100 p-2">Add Task</button>
    </a>
  <%if (tasks != null) { %>
    <%for (Task task : tasks) {
      boolean done = task.getIsDone();
    %>
      <div class="d-flex flex-column mt-5">
          <%--Task Index--%>
          <h3 class="mb-2">Task <span class="fw-bold"># </span> <%=mobileIndex++%></h3>
          <%--Task Title--%>
          <div class="d-flex align-content-center">
            <h5 class="mb-0 <%=done ? "text-decoration-line-through" : "" %>"><%=task.getTitle()%>
              <span class="<%=done ? "badge bg-success text-white" : "badge bg-danger text-white"%> ms-4"><%=done ? "Completed" : "Pending" %></span>
            </h5>
          </div>
            <%--Task Data--%>
            <p class="text-start fst-italic text-secondary"><%=DateConversionToString.getFormattedDate(task.getDueDate(), "EEE, dd MMM yyyy")%>
            </p>
          <%--PRIORITY--%>
          <%if (task.getPriority().toString().equals("URGENT") || task.getPriority().toString().equals("HIGH")) {%>
            <p class="fw-bold m-0 mt-1  ">Priority: <span class="text-danger"><%=StringUtils.toCapitalCase(task.getPriority().toString())%></span></p>
          <%} else {%>
            <p class="fw-bold m-0 mt-1">Priority: <span><%=StringUtils.toCapitalCase(task.getPriority().toString())%></span></p>
          <%}%>
          <%--CATEGORY--%>
          <p class="fw-bold m-0 mt-1">Category: <span class="fw-normal">
            <%if (taskCategory != null) {%>
            <%
              List<String> displayCategories = taskCategory.get(task.getId().toString());
            %>
            <%if (displayCategories != null) {%>
              <%for (String category : displayCategories) {%>
                <span class="fs-6"><%=StringUtils.toCapitalCase(category)%></span>
              <%}%>
            <%} else {%>
              <span>No category</span>
            <%}%>
          <%}%>
          </span>
          </p>
          <%--DESCRIPTION--%>
          <p class="mt-2"><span class="fw-bold">Description</span><br><%=task.getDescription()%></p>
          <%--BUTTONS--%>
          <div class="pt-3" role="group" aria-label="Basic mixed styles example">
            <form action="${pageContext.request.contextPath}/dashboard" method="get">
              <input type="hidden" name="_method" value="put">
              <input type="hidden" name="action" value="<%= done ? "reset" : "complete"%>">
              <input type="hidden" name="task_id" value="<%=task.getId()%>">
              <button type="submit" class="btn <%=done ? "btn-warning" : "btn-success"%> w-100">
                <%=done ? "Reset" : "Complete"%>
              </button>
            </form>
            <form action="${pageContext.request.contextPath}/dashboard" method="get">
              <input type="hidden" name="_method" value="delete">
              <input type="hidden" name="task_id" value="<%=task.getId()%>">
              <button type="submit" class="btn btn-danger w-100 me-3"
                onclick="return confirm('This action cannot be undone. Are you sure you want to delete this task?');"
              >Delete</button>
            </form>
          </div>
        <%}%>
  </div>
  <%}%>
</div>