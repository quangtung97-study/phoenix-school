function get_value(e, name) {
    input = e.find("input[name=" + name + "]");
    return input.val();
}

function update_button(e) {
    map = {
        "_csrf_token": get_value(e, "_csrf_token"),
        "id": get_value(e, "id"),
        "class_id": get_value(e, "class_id"),

        "day": get_value(e, "day"),
        "diemgioi": get_value(e, "diemgioi"),
        "diemkha": get_value(e, "diemkha"),
        "diemtb": get_value(e, "diemtb"),
        "diemyeu": get_value(e, "diemyeu"),
        "diemkem": get_value(e, "diemkem"),

        "giotot": get_value(e, "giotot"),
        "giokha": get_value(e, "giokha"),
        "giotb": get_value(e, "giotb"),
    };
    $.post("/hoctap/loptruong/update/", map)
        .always(function() { location.reload(); });
}

function delete_button(e) {
    map = {
        "_csrf_token": get_value(e, "_csrf_token"),
        "id": get_value(e, "id"),
        "class_id": get_value(e, "class_id"),

        "day": get_value(e, "day"),
        "diemgioi": get_value(e, "diemgioi"),
        "diemkha": get_value(e, "diemkha"),
        "diemtb": get_value(e, "diemtb"),
        "diemyeu": get_value(e, "diemyeu"),
        "diemkem": get_value(e, "diemkem"),

        "giotot": get_value(e, "giotot"),
        "giokha": get_value(e, "giokha"),
        "giotb": get_value(e, "giotb"),
    };
    $.post("/hoctap/loptruong/delete/", map)
        .always(function() { location.reload(); });
}

function add_button(e) {
    map = {
        "_csrf_token": get_value(e, "_csrf_token"),
        "id": get_value(e, "id"),
        "class_id": get_value(e, "class_id"),

        "day": get_value(e, "day"),
        "diemgioi": get_value(e, "diemgioi"),
        "diemkha": get_value(e, "diemkha"),
        "diemtb": get_value(e, "diemtb"),
        "diemyeu": get_value(e, "diemyeu"),
        "diemkem": get_value(e, "diemkem"),

        "giotot": get_value(e, "giotot"),
        "giokha": get_value(e, "giokha"),
        "giotb": get_value(e, "giotb"),
    };
    $.post("/hoctap/loptruong/add/", map)
        .always(function() { location.reload(); });
}
