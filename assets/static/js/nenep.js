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

        "siso": get_value(e, "siso"),
        "khanquang": get_value(e, "khanquang"),
        "dongphuc": get_value(e, "dongphuc"),
        "vesinh": get_value(e, "vesinh"),

        "chaoco": get_value(e, "chaoco"),
        "truybai": get_value(e, "truybai"),
        "bakhong": get_value(e, "bakhong"),
        "shdoi": get_value(e, "shdoi"),

        "tdvuichoi": get_value(e, "tdvuichoi"),
        "nghithucdoi": get_value(e, "nghithucdoi"),
        "ghichu": get_value(e, "ghichu"),
    };
    return map;
}

function update_button(e) {
    $.post("/nenep/update/", get_map(e))
        .always(function() { location.reload(); });
}

function delete_button(e) {
    $.post("/nenep/delete/", get_map(e))
        .always(function() { location.reload(); });
}

function add_button(e) {
    $.post("/nenep/add/", get_map(e))
        .always(function() { location.reload(); });
}
