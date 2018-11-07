defmodule SchoolWeb.HoctapController do
  use SchoolWeb, :controller
  import SchoolWeb.AccountController, only: [basic_assigns: 1]

  defp index_case(conn, assigns, true, _) do
    render(conn, "loptruong.html", assigns)
  end

  defp index_case(conn, assigns, false, true) do
    render(conn, "loptruong.html", assigns)
  end

  defp index_case(conn, _assigns, _, _) do
    redirect(conn, to: "/")
  end

  def index(conn, _params) do
    assigns = %{basic_assigns(conn) | 
      title: "Học Tập", 
      page: :hoctap,
    }

    is_admin = assigns.account.is_admin
    is_loptruong = assigns.account.is_loptruong
    index_case(conn, assigns, is_admin, is_loptruong)
  end
end
