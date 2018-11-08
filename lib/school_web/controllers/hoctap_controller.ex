defmodule SchoolWeb.HoctapController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]
  alias School.HocTapManager
  alias School.Week
  alias SchoolWeb.HoctapView, as: View

  # For admin
  defp index_case(conn, params, assigns, true, _is_loptruong) do
    classes = HocTapManager.classes()
    class = View.get_class(params, classes)
    week_start_date = View.get_week_start_date(params)

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
        Week.nearest_start_dates(3))

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
      |> Map.put(:week_start_date, Week.current_week())
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

  def add(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    HocTapManager.new(map, account_id)
    text(conn, "")
  end

  def update(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    HocTapManager.update(map, account_id)
    text(conn, "")
  end

  def delete(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    HocTapManager.delete(map, account_id)
    text(conn, "")
  end
end
