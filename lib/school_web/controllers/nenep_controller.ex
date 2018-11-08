defmodule SchoolWeb.NenepController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]
  alias School.AccountManager
  alias School.NeNepManager
  alias SchoolWeb.NenepView, as: View
  alias School.Week

  def index(conn, _params) do
    account_id = get_session(conn, :account_id)
    account = AccountManager.get(account_id)
    case {account.is_admin, account.is_saodo} do
      {true, _} -> 
        redirect(conn, to: "/nenep/admin/")
      {false, true} -> 
        redirect(conn, to: "/nenep/saodo/")
      _ ->
        redirect(conn, to: "/")
    end
  end

  def index_saodo(conn, params) do
    assigns = %{basic_assigns(conn) | 
      title: "Nề Nếp", 
      page: :nenep,
    }
    account = assigns.account
    if account.is_saodo do
      classes = NeNepManager.classes()
      class = View.get_class(params, classes)

      week = 
        NeNepManager.week(class.id)
        |> Stream.map(fn e -> {e.day + 1, e} end)
        |> Map.new()

      assigns = 
        assigns
        |> Map.put(:classes, classes)
        |> Map.put(:class, class)
        |> Map.put(:week, week)
        |> Map.put(:week_start_date, Week.current_week())

      render(conn, "saodo.html", assigns)
    else
      redirect(conn, to: "/")
    end
  end

  def index_admin(conn, params) do
    assigns = %{basic_assigns(conn) | 
      title: "Nề Nếp", 
      page: :nenep,
    }
    account = assigns.account
    if account.is_admin do
      classes = NeNepManager.classes()
      class = View.get_class(params, classes)
      week_start_date = View.get_week_start_date(params)

      week = 
        NeNepManager.week(class.id, week_start_date)
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
    else
      redirect(conn, to: "/")
    end
  end

  def add(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    NeNepManager.new(map, account_id)
    text(conn, "")
  end

  def update(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    NeNepManager.update(map, account_id)
    text(conn, "")
  end

  def delete(conn, params) do
    account_id = get_session(conn, :account_id)
    map = 
      View.param_map(params)
      |> Map.put(:current_week, Week.current_week())
    NeNepManager.delete(map, account_id)
    text(conn, "")
  end
end
