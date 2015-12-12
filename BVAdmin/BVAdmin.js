$(document).ready(function () {
    // select all checkbox
    $(".selectAll input:checkbox").click(function () {
        var checked = $(this).is(":checked");
        var gridView = $(this).closest("table");
        $("input:checkbox", gridView).prop("checked", checked);
    });
});