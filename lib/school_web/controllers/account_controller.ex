defmodule SchoolWeb.AccountController do
  use SchoolWeb, :controller
  alias School.AccountManager

  def basic_assigns(conn) do
    account_id = get_session(conn, :account_id)
    account = AccountManager.get(account_id)
    %{
      title: "",
      page: nil,
      account: account,
      token: get_csrf_token()
    }
  end

  def login(conn, _params) do
    assigns = %{basic_assigns(conn) |
      title: "Đăng nhập", 
      page: :login,
    }
    render(conn, "login.html", assigns)
  end

  def login_post(conn, params) do
    username = params["username"]
    password = params["password"]
    account_id = AccountManager.login(username, password)
    conn = put_session(conn, :account_id, account_id)
    redirect conn, to: "/"
  end

  def logout(conn, _params) do
    conn = delete_session(conn, :account_id)
    redirect conn, to: "/"
  end

  def index(conn, _params) do 
    assigns = %{basic_assigns(conn) |
      title: "Tài khoản", 
      page: :account,
    }
    render(conn, "index.html", assigns)
  end

  defp handle_change_password(conn, account_id, old_pwd, new_pwd) do
    case AccountManager.change_password(
      account_id, old_pwd, new_pwd) do
      :ok -> redirect conn, to: "/account/succeed"
      :fail -> redirect conn, to: "/account/"
    end
  end

  def change_password(conn, params) do 
    account_id = get_session(conn, :account_id)
    old_password = params["old-password"]
    new_password = params["new-password"]
    confirmed_new_password = params["confirmed-new-password"]
    if new_password == confirmed_new_password do
      handle_change_password(conn, 
        account_id, old_password, new_password)
    else
      redirect conn, to: "/account/"
    end
  end

  def succeed(conn, _params) do
    assigns = %{basic_assigns(conn) |
      title: "Thành công",
      page: :succeed,
    }
    render(conn, "succeed.html", assigns)
  end
end
