function get_value(e, name) {
    input = e.find("input[name=" + name + "]");
    return input.val();
}

function get_map(e) {
    map = {
        "_csrf_token": get_value(e, "_csrf_token"),
        "id": get_value(e, "id"),
        "class_id": get_value(e, "class_id"),

        "day": get_value(e, "day"),
        "week_start_date": get_value(e, "week_start_date"),

        "diemgioi": get_value(e, "diemgioi"),
        "diemkha": get_value(e, "diemkha"),
        "diemtb": get_value(e, "diemtb"),
        "diemyeu": get_value(e, "diemyeu"),
        "diemkem": get_value(e, "diemkem"),

        "giotot": get_value(e, "giotot"),
        "giokha": get_value(e, "giokha"),
        "giotb": get_value(e, "giotb"),
    };
    return map;
}

function update_button(e) {
    $.post("/hoctap/update/", get_map(e))
        .always(function() { location.reload(); });
}

function delete_button(e) {
    $.post("/hoctap/delete/", get_map(e))
        .always(function() { location.reload(); });
}

function new_button(e) {
    $.post("/hoctap/new/", get_map(e))
        .always(function() { location.reload(); });
}
