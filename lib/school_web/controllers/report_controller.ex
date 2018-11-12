defmodule SchoolWeb.ReportController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]
  alias School.ReportManager
  alias SchoolWeb.ReportView, as: View

  def index(conn, _params) do
    assigns = %{basic_assigns(conn) |
      title: "Báo cáo",
      page: :report,
    }
    account = assigns.account

    [_|status_list] = ReportManager.list(:status, 6)
    assigns = 
      assigns 
      |> Map.put(:status_list, status_list)

    if account != nil and account.is_admin do
      render(conn, "index.html", assigns)
    else 
      redirect(conn, to: "/")
    end
  end

  def add(conn, params) do
    account_id = get_session(conn, :account_id)
    map = View.param_map(params)
    ReportManager.new(map, account_id)
    text(conn, "")
  end
end
