defmodule SchoolWeb.HomeController do
  use SchoolWeb, :controller
  alias School.AccountManager

  def index(conn, _params) do
    account_id = get_session(conn, :account_id)
    account = AccountManager.get(account_id)
    assigns = %{
      title: "Trang chủ", 
      page: :home,
      account: account,
      token: get_csrf_token(),
    }
    render(conn, "index.html", assigns)
  end
end
