function get_value(e, name) {
    input = e.find("input[name=" + name + "]");
    return input.val();
}

function get_map(e) {
    map = {
        "_csrf_token": get_value(e, "_csrf_token"),
        "id": get_value(e, "id"),
        "class_id": get_value(e, "class_id"),
        "week_start_date": get_value(e, "week_start_date"),
        "diemtru": get_value(e, "diemtru"),
    };
    return map;
}

function new_diemtru(e) {
    $.post("/diemtru/new/", get_map(e))
        .always(function() { location.reload(); });
}

function update_diemtru(e) {
    $.post("/diemtru/update/", get_map(e))
        .always(function() { location.reload(); });
}

function delete_diemtru(e) {
    $.post("/diemtru/delete/", get_map(e))
        .always(function() { location.reload(); });
}
