function get_value(e, name) {
    input = e.find("input[name=" + name + "]");
    return input.val();
}

function get_map(e) {
    return {
        "_csrf_token": get_value(e, "_csrf_token"),
        "week_start_date": get_value(e, "week_start_date"),
    };
}

function add_report(e) {
    $.post("/report/add/", get_map(e))
        .always(function() { location.reload(); });
}

function update_report(e) {
    $.post("/report/update/", get_map(e))
        .always(function() { location.reload(); });
}
