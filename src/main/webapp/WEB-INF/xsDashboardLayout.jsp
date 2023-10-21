
<div class="small_screen_layout">
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