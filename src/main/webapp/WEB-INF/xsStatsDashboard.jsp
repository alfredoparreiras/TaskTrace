<div class="large_screen_layout w-35 align-self-center mt-5">
    <%if (stats != null) {%>
    <div class="d-flex align-items-center justify-content-between">
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
    <div class="d-flex align-items-center justify-content-between">
        <div class="border border-opacity-50 rounded border-2 py-2 px-3 m-3 d-flex flex-column">
            <h4>Overdue</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-50 align-self-center">
        </div>
        <div class="border border-opacity-50 rounded border-2 py-2 px-3 m-3 d-flex flex-column">
            <h4>Ongoing</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-50 align-self-center">
        </div>
        <div class="border border-opacity-50 rounded border-2 py-2 px-3 m-3 d-flex flex-column">
            <h4 class="">Complete</h4>
            <img src="${pageContext.request.contextPath}/resources/images/icons/unknown.svg"
                 alt="Icon that represents an Unknown symbol" class="w-50 align-self-center">
        </div>
    </div>
    <%}%>
</div>


<div class="small_screen_layout mt-4">
    <%if (stats != null) {%>
    <div class="d-flex flex-column">
        <div class="mb-2">
            <h5>Overdue : <span class="text-danger fw-bold fs-3"><%=overdue%></span></h5>
        </div>
        <div class="mb-2">
            <h5>Ongoing : <span class="fw-bold fs-3"><%=ongoing%></span></h5>
        </div>
        <div class="mb-2">
            <h5 class="">Complete : <span class="text-center text-success fw-bold fs-3"><%=complete%></span></h5>
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
</div>
