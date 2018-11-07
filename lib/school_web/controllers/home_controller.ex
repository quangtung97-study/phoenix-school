defmodule SchoolWeb.HomeController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]

  def index(conn, _params) do
    assigns = %{basic_assigns(conn) | 
      title: "Trang chủ", 
      page: :home,
    }
    render(conn, "index.html", assigns)
  end
end
