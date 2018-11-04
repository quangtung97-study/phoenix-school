defmodule School.AccountManager do 
  alias School.Account
  alias School.Repo

  @spec login(String.t(), String.t()) :: nil | integer()
  def login(username, password) do
    case Repo.get_by(Account, username: username) do
      nil -> nil
      account -> 
        if Account.password_correct?(account, password) do
          account.id
        end
    end
  end

  @spec change_password(integer(), String.t(), String.t()) :: :ok | :fail
  def change_password(account_id, old_pwd, new_pwd) do
    result = 
      Repo.get(Account, account_id)
      |> Account.change_password(old_pwd, new_pwd)
      |> Repo.update()
    case result do
      {:ok, _} -> :ok
      {:error, _} -> :fail
    end
  end
end
