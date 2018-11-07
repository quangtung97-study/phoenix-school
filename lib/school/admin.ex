defmodule School.Admin do
  alias School.Repo
  alias School.Account
  import Ecto.Query, only: [from: 2]

  def new(username, password) do
    Account.new(username, password)
    |> Repo.insert()
  end

  def delete(account_id) do
    if account_id != nil do
      Repo.delete(%Account{id: account_id})
    end
  end

  def classes() do
    Repo.all(School.Class)
  end

  def list() do
    Repo.all(Account)
  end

  def list(:admin) do 
    query = from a in Account, where: a.is_admin == true
    Repo.all(query)
  end

  def list(:saodo) do
    query = from a in Account, where: a.is_saodo == true
    Repo.all(query)
  end

  def list(:loptruong) do
    query = from a in Account, where: a.is_loptruong == true
    Repo.all(query) |> Repo.preload(:class)
  end

  def add(:admin, account_id) do
    %Account{id: account_id}
    |> Account.add_privilege(:admin)
    |> Repo.update()
  end

  def add(:saodo, account_id) do
    %Account{id: account_id}
    |> Account.add_privilege(:saodo)
    |> Repo.update()
  end

  def add(:loptruong, account_id, class_id) do
    %Account{id: account_id}
    |> Account.add_privilege(:loptruong, class_id)
    |> Repo.update()
  end

  def remove(:admin, account_id) do
    %Account{id: account_id}
    |> Account.remove_privilege(:admin)
    |> Repo.update()
  end

  def remove(:saodo, account_id) do
    %Account{id: account_id}
    |> Account.remove_privilege(:saodo)
    |> Repo.update()
  end

  def remove(:loptruong, account_id) do
    %Account{id: account_id}
    |> Account.remove_privilege(:loptruong)
    |> Repo.update()
  end

  def new_class(classname) do
    School.Class.new(classname)
    |> Repo.insert()
  end

  def delete_class(class_id) do
    try do
      class_id
      |> School.Class.delete()
      |> Repo.delete()
    rescue
      _ -> nil
    end
  end
end
