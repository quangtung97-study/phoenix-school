defmodule School.AccountManager do 
  alias School.Account
  alias School.Repo

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
end
