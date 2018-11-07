defmodule School.AccountManager do 
  alias School.Account
  alias School.Repo
  import Ecto.Query, only: [from: 1]

  def get(nil), do: nil

  def get(account_id) do
    Repo.get(Account, account_id)
  end

  def login(username, password) do
    case Repo.get_by(Account, username: username) do
      nil -> nil
      account -> 
        if Account.password_correct?(account, password) do
          account.id
        end
    end
  end

  def change_password(account_id, old_pwd, new_pwd) do
    result = 
      Repo.get!(Account, account_id)
      |> Account.change_password(old_pwd, new_pwd)
      |> Repo.update()
    case result do
      {:ok, _} -> :ok
      {:error, _} -> :fail
    end
  end

  def new(username, password) do
    Account.new(username, password)
    |> Repo.insert()
  end

  def delete(account_id) do
    if account_id != nil do
      Repo.delete(%Account{id: account_id})
    end
  end

  def list do
    query = from a in Account
    Repo.all(query)
  end
end
