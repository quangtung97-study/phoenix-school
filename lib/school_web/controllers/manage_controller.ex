defmodule SchoolWeb.ManageController do
  use SchoolWeb, :controller
  alias School.AccountManager
  import SchoolWeb.AccountController, only: [basic_assigns: 1]

  defp allow?(conn) do
    account_id = get_session(conn, :account_id)
    account = AccountManager.get(account_id)
    account.is_admin
  end

  def index(conn, __params) do
    assigns = %{basic_assigns(conn) |
      title: "Quản lý",
      page: :manage,
    }

    if assigns.account.is_admin do
      accounts = AccountManager.list()
      assigns = Map.put(assigns, :accounts, accounts)
      render(conn, "index.html", assigns)
    else
      redirect(conn, to: "/")
    end
  end

  def new_account(conn, params) do
    if allow?(conn) do
      username = params["username"]
      password = params["password"]
      confirmed_password = params["confirmed-password"]
      if password == confirmed_password do
        AccountManager.new(username, password)
      end
      redirect(conn, to: "/manage/")
    else
      redirect(conn, to: "/")
    end
  end

  def delete_accounts(conn, params) do
    if allow?(conn) do
      params
      |> Map.to_list()
      |> Stream.filter(fn {key, _} ->
        str = "account_id"
        len = String.length(str) - 1
        String.slice(key, 0..len) == str
      end)
      |> Stream.map(fn {_, value} -> value end)
      |> Stream.map(fn value -> 
        {num, _} = Integer.parse(value)
        num
      end)
      |> Enum.map(&AccountManager.delete/1)

      redirect(conn, to: "/manage/")
    else
      redirect(conn, to: "/")
    end
  end
end
