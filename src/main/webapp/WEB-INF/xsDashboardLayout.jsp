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
      </tr>
      </thead>
      <tbody class="table-group-divider">
      <%if (tasks != null) { %>
      <%for (Task task : tasks) {%>
      <%--If Task is complete we must change the row style.--%>
      <%if (task.getIsDone()) {%>
      <tr class="text-decoration-line-through">
        <th class="align-middle" scope="row"><%=index++%></th>
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
          List<String> displayCategories = new ArrayList<>();
          displayCategories = taskCategory.get(task.getId().toString());
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
          List<String> displayCategories = new ArrayList<>();
          displayCategories = taskCategory.get(task.getId().toString());
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
  </div>
</div>


<div class="small_screen_layout">
  <div style="display: flex; justify-content: flex-end;">
    <a href="${pageContext.request.contextPath}/addTask">
      <button type="button" class="btn btn-outline-primary mb-2">Add Task</button>
    </a>
  </div>
  <%if (tasks != null) { %>
    <%for (Task taskList : tasks) {%>
      <div class="mt-4">
        <%if (!taskList.getIsDone()) {%>
          <p class="fs-6">Task <span class="fw-bold"># </span> <%=mobileIndex++%></p>
          <div class="d-flex justify-content-between">
            <h4 class=""><%=taskList.getTitle()%></h4>
            <p class="fst-italic"><%=DateConversionToString.getFormattedDate(taskList.getDueDate(), "EEE, dd MMM yyyy")%></p>
          </div>
          <%if (taskList.getPriority().toString().equals("URGENT") || taskList.getPriority().toString().equals("HIGH")) {%>
            <p class="text-danger"><%=StringUtils.toCapitalCase(taskList.getPriority().toString())%></p>
          <%} else {%>
            <p><%=StringUtils.toCapitalCase(taskList.getPriority().toString())%></p>
          <%}%>
          <p class="fw-bold">Category</p>
          <%if (taskCategory != null) {%>
            <%
              List<String> displayCategories = taskCategory.get(taskList.getId());
            %>
            <%if (displayCategories != null) {%>
              <%for (String category : displayCategories) {%>
                <p class="fs-6"><%=StringUtils.toCapitalCase(category)%></p>
              <%}%>
            <%} else {%>
              <p>No category</p>
            <%}%>
          <%}%>
          <p class="mt-2"><span class="fw-bold">Description</span><br><%=taskList.getDescription()%></p>
          <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
            <form action="${pageContext.request.contextPath}/dashboard" method="get">
              <input type="hidden" name="_method" value="delete">
              <input type="hidden" name="task_id" value="<%=taskList.getId()%>">
              <button type="submit" class="btn btn-danger me-3">Delete</button>
            </form>
            <form action="${pageContext.request.contextPath}/dashboard" method="get">
              <input type="hidden" name="_method" value="put">
              <input type="hidden" name="action" value="done">
              <input type="hidden" name="task_id" value="<%=taskList.getId()%>">
              <button type="submit" class="btn btn-success">Done</button>
            </form>
          </div>
    <%} else {%>
      <p class="fs-6">Task <span class="fw-bold">#</span><%=mobileIndex++%></p>
      <div class="d-flex justify-content-between">
        <h4 class="text-decoration-line-through"><%=taskList.getTitle()%></h4>
        <p class="fst-italic"><%=DateConversionToString.getFormattedDate(taskList.getDueDate(), "EEE, dd MMM yyyy")%></p>
      </div>
      <%if (taskList.getPriority().toString().equals("URGENT") || taskList.getPriority().toString().equals("HIGH")) {%>
        <p class="text-danger"><%=StringUtils.toCapitalCase(taskList.getPriority().toString())%></p>
      <%} else {%>
        <p><%=StringUtils.toCapitalCase(taskList.getPriority().toString())%></p>
      <%}%>
      <p class="fw-bold">Category</p>
      <%if (taskCategory != null) {%>
        <%
          List<String> displayCategories = taskCategory.get(taskList.getId());
        %>
          <%if (displayCategories != null) {%>
            <%for (String category : displayCategories) {%>
              <p class="fs-6"><%=StringUtils.toCapitalCase(category)%></p>
            <%}%>
          <%} else {%>
          <p>No category</p>
          <%}%>
        <%}%>
    <p class="mt-2"><span class="fw-bold">Description</span><br><%=taskList.getDescription()%>
    </p>
    <div class="d-flex pt-3" role="group" aria-label="Basic mixed styles example">
      <form action="${pageContext.request.contextPath}/dashboard" method="get">
        <input type="hidden" name="_method" value="delete">
        <input type="hidden" name="task_id" value="<%=taskList.getId()%>">
        <button type="submit" class="btn btn-danger me-3">Delete</button>
      </form>
      <form action="${pageContext.request.contextPath}/dashboard" method="get">
        <input type="hidden" name="_method" value="put">
        <input type="hidden" name="action" value="undo">
        <input type="hidden" name="task_id" value="<%=taskList.getId()%>">
        <button type="submit" class="btn btn-warning">Undo</button>
      </form>
    </div>
    <%}%>
  </div>
  <%}%>
  <%}%>
</div>