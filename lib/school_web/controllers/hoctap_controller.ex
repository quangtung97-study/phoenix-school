defmodule SchoolWeb.HoctapController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]
  alias School.HocTapManager

  defp get_class(params, classes) do
    if params["class_id"] == nil do
      {:ok, e} = Enum.fetch(classes, 0)
      e
    else
      {id, _} = Integer.parse(params["class_id"])
      Enum.find(classes, fn c -> c.id == id end)
    end
  end

  defp get_week_start_date(params) do 
    if params["week_start_date"] == nil do
      HocTapManager.current_week()
    else
      {start_date, _} = Integer.parse(params["week_start_date"])
      start_date
    end
  end

  # For admin
  defp index_case(conn, params, assigns, true, _is_loptruong) do
    classes = HocTapManager.classes()
    class = get_class(params, classes)

    week_start_date = get_week_start_date(params)
    week = 
      HocTapManager.week(class.id, week_start_date)
      |> Stream.map(fn e -> {e.day + 1, e} end)
      |> Map.new()

    assigns = 
      assigns
      |> Map.put(:classes, classes)
      |> Map.put(:class, class)
      |> Map.put(:week, week)
      |> Map.put(:week_start_date, week_start_date)
      |> Map.put(:nearest_start_dates, 
        HocTapManager.nearest_start_dates(3))

    render(conn, "admin.html", assigns)
  end

  # For loptruong
  defp index_case(conn, _params, assigns, false, true) do
    class = HocTapManager.class(assigns.account.class_id)
    week = 
      HocTapManager.week(class.id)
      |> Stream.map(fn e -> {e.day + 1, e} end)
      |> Map.new()

    assigns = 
      assigns 
      |> Map.put(:class, class)
      |> Map.put(:week, week)
      |> Map.put(:week_start_date, HocTapManager.current_week())
    render(conn, "loptruong.html", assigns)
  end

  defp index_case(conn, _params, _assigns, _is_admin, _is_loptruong) do
    redirect(conn, to: "/")
  end

  def index(conn, params) do
    assigns = %{basic_assigns(conn) | 
      title: "Học Tập", 
      page: :hoctap,
    }

    is_admin = assigns.account.is_admin
    is_loptruong = assigns.account.is_loptruong
    index_case(conn, params, assigns, is_admin, is_loptruong)
  end

  defp put(map, params, name) do
    case Integer.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, num)
      :error -> Map.put(map, name, 0)
    end
  end

  defp param_map(params) do
    %{}
    |> put(params, :id)
    |> put(params, :class_id)
    |> put(params, :day)
    |> put(params, :diemgioi)
    |> put(params, :diemkha)
    |> put(params, :diemtb)
    |> put(params, :diemyeu)
    |> put(params, :diemkem)
    |> put(params, :giotot)
    |> put(params, :giokha)
    |> put(params, :giotb)
  end

  def add(conn, params) do
    account_id = get_session(conn, :account_id)
    map = param_map(params)
    HocTapManager.new(map, account_id)
    text(conn, "")
  end

  def update(conn, params) do
    account_id = get_session(conn, :account_id)
    map = param_map(params)
    HocTapManager.update(map, account_id)
    text(conn, "")
  end

  def delete(conn, params) do
    account_id = get_session(conn, :account_id)
    map = param_map(params)
    HocTapManager.delete(map, account_id)
    text(conn, "")
  end
end
