defmodule SchoolWeb.ManageController do
  use SchoolWeb, :controller
  alias School.AccountManager
  alias School.Admin
  import SchoolWeb.AccountController, only: [basic_assigns: 1]

  def index(conn, __params) do
    assigns = %{basic_assigns(conn) |
      title: "Quản lý",
      page: :manage,
    }

    if assigns.account.is_admin do
      accounts = Admin.list()
      admins = Admin.list(:admin)
      saodos = Admin.list(:saodo)
      loptruongs = Admin.list(:loptruong)
      classes = Admin.classes()

      assigns =
        assigns
        |> Map.put(:accounts, accounts)
        |> Map.put(:admins, admins)
        |> Map.put(:saodos, saodos)
        |> Map.put(:loptruongs, loptruongs)
        |> Map.put(:classes, classes)

      render(conn, "index.html", assigns)
    else
      redirect(conn, to: "/")
    end
  end

  defp allow?(conn) do
    account_id = get_session(conn, :account_id)
    account = AccountManager.get(account_id)
    account.is_admin
  end

  defp admin_do(conn, fun) do
    if allow?(conn) do
      hashtag = fun.()
      redirect(conn, to: "/manage/##{hashtag}")
    else
      redirect(conn, to: "/")
    end
  end

  def new_account(conn, params) do
    conn
    |> admin_do(fn ->
      username = params["username"]
      password = params["password"]
      confirmed_password = params["confirmed-password"]
      if password == confirmed_password do
        Admin.new(username, password)
      end
      :new
    end)
  end

  defp params_to_ids(params) do
    params
    |> Map.to_list()
    |> Stream.filter(fn {key, _} ->
      str = "string_id"
      len = String.length(str) - 1
      String.slice(key, 0..len) == str
    end)
    |> Stream.map(fn {_, value} -> value end)
    |> Stream.map(fn value -> 
      {num, _} = Integer.parse(value)
      num
    end)
  end

  def delete_accounts(conn, params) do
    conn
    |> admin_do(fn ->
      params
      |> params_to_ids()
      |> Enum.map(&Admin.delete/1)
      :delete
    end)
  end

  def add_admin(conn, params) do
    conn
    |> admin_do(fn ->
      {id, _} = 
        params["account"]
        |> Integer.parse()
      Admin.add(:admin, id)
      :admin
    end)
  end

  def add_saodo(conn, params) do
    conn
    |> admin_do(fn ->
      {id, _} = 
        params["account"]
        |> Integer.parse()
      Admin.add(:saodo, id)
      :saodo
    end)
  end

  def add_loptruong(conn, params) do
    conn
    |> admin_do(fn ->
      {id, _} = 
        params["account"]
        |> Integer.parse()
      {class_id, _} = 
        params["class"]
        |> Integer.parse()
      Admin.add(:loptruong, id, class_id)
      :loptruong
    end)
  end

  def remove_admins(conn, params) do
    conn
    |> admin_do(fn -> 
      params
      |> params_to_ids()
      |> Enum.map(&Admin.remove(:admin, &1))
      :admin
    end)
  end

  def remove_saodos(conn, params) do
    conn
    |> admin_do(fn ->
      params
      |> params_to_ids()
      |> Enum.map(&Admin.remove(:saodo, &1))
      :saodo
    end)
  end

  def remove_loptruongs(conn, params) do
    conn
    |> admin_do(fn ->
      params
      |> params_to_ids()
      |> Enum.map(&Admin.remove(:loptruong, &1))
      :saodo
    end)
  end

  def new_class(conn, params) do
    conn
    |> admin_do(fn ->
      params["classname"]
      |> Admin.new_class()
      :"new-class"
    end)
  end

  def delete_classes(conn, params) do
    conn
    |> admin_do(fn ->
      params
      |> params_to_ids()
      |> Enum.map(&Admin.delete_class(&1))
      :"delete-class"
    end)
  end
end
