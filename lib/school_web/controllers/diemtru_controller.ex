defmodule SchoolWeb.DiemtruController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]
  alias SchoolWeb.DiemtruView, as: View
  alias School.Week
  alias School.DiemTruManager

  def index(conn, params) do
    assigns = %{basic_assigns(conn) |
      title: "Điểm cộng / trừ", 
      page: :diemtru,
    }

    week_start_date = View.get_week_start_date(params)
    diemtru_week = DiemTruManager.week(week_start_date)

    assigns =
      assigns
      |> Map.put(:week, diemtru_week)
      |> Map.put(:week_start_date, week_start_date)
      |> Map.put(:nearest_start_dates, 
        Week.nearest_start_dates(6))

    render(conn, "index.html", assigns)
  end

  def new(conn, params) do
    account_id = get_session(conn, :account_id)
    map = View.param_map(params)
    DiemTruManager.new(map, account_id)
    text(conn, "")
  end

  def update(conn, params) do
    account_id = get_session(conn, :account_id)
    map = View.param_map(params)
    DiemTruManager.update(map, account_id)
    text(conn, "")
  end

  def delete(conn, params) do
    account_id = get_session(conn, :account_id)
    map = View.param_map(params)
    DiemTruManager.delete(map, account_id)
    text(conn, "")
  end
end
