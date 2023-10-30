<div class="large_screen_layout w-35 align-self-center mt-5">
    <div class="d-flex align-items-center justify-content-between">
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4>Overdue</h4>
            <p class="text-danger fw-bold fs-3 m-0 text-center"><%=overdue != null ? overdue : "0"%></p>
        </div>
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4>Ongoing</h4>
            <p class="text-primary fw-bold fs-3 m-0 text-center"><%=ongoing != null ? ongoing : "0"%></p>
        </div>
        <div class="border border-opacity-50 rounded border-2 pt-2 px-3 m-3">
            <h4 class="">Complete</h4>
            <p class="text-success fw-bold fs-3 m-0 text-center"><%=complete != null ? complete : "0"%></p>
        </div>
    </div>
</div>


<div class="small_screen_layout mt-4">
    <div class="container mb-4 p-3">
        <div class="row">
            <!-- First row, first column -->
            <div class="col-6 text-center">
                <h5 class="m-0">Overdue:</h5>
            </div>
            <!-- First row, second column -->
            <div class="col-6 text-center">
                <p class="text-danger fw-bold fs-3 m-0"><%=overdue != null ? overdue : "0"%></p>
            </div>
            <!-- Second row, first column -->
            <div class="col-6 text-center">
                <h5 class="m-0">Ongoing:</h5>
            </div>
            <!-- Second row, second column -->
            <div class="col-6 text-center">
                <p class="fw-bold fs-3 m-0"><%=ongoing != null ? ongoing : "0"%></p>
            </div>
            <!-- Third row, first column -->
            <div class="col-6 text-center">
                <h5 class="m-0">Complete:</h5>
            </div>
            <!-- Third row, second column -->
            <div class="col-6 text-center">
                <p class="text-success fw-bold fs-3 m-0"><%=complete != null ? complete : "0"%></p>
            </div>
        </div>
    </div>
</div>
