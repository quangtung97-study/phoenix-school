defmodule School.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account" do
    field :username, :string
    field :password, :string
    field :is_admin, :boolean
    field :is_saodo, :boolean
    field :is_loptruong, :boolean
    belongs_to :class, School.Class, foreign_key: :class_id
  end

  defp new_changeset(account, params) do
    account
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 4, max: 50)
    |> validate_length(:password, min: 4)
    |> update_change(:password, &Bcrypt.hash_pwd_salt/1)
    |> validate_length(:password, is: 60)
    |> unique_constraint(:username)
  end

  def new(username, password) do
    params = %{
      username: username, 
      password: password,
    }

    new_changeset(%School.Account{}, params)
  end

  def add_privilege(account, :admin) do
    account
    |> cast(%{is_admin: true}, [:is_admin])
  end

  def add_privilege(account, :saodo) do
    account
    |> cast(%{is_saodo: true}, [:is_saodo])
  end

  def add_privilege(account, :loptruong, class_id) do
    params = %{is_loptruong: true, class_id: class_id}
    account
    |> cast(params, [:is_loptruong, :class_id])
    |> validate_required([:class_id])
  end

  def remove_privilege(account, :admin) do
    account
    |> cast(%{is_admin: false}, [:is_admin])
  end

  def remove_privilege(account, :saodo) do
    account
    |> cast(%{is_saodo: false}, [:is_saodo])
  end

  def remove_privilege(account, :loptruong) do 
    params = %{is_loptruong: false, class_id: nil}
    account
    |> cast(params, [:is_loptruong, :class_id])
  end

  def password_correct?(account, password) do
    Bcrypt.verify_pass(password, account.password)
  end

  def change_password(account, old_pwd, new_pwd) do
    params = %{password: new_pwd}

    verify_pass = fn changeset ->
      case password_correct?(account, old_pwd) do
        true -> changeset
        false -> add_error(changeset, :password, "Password is not correct")
      end
    end

    account
    |> cast(params, [:password])
    |> verify_pass.()
    |> validate_length(:password, min: 4)
    |> update_change(:password, &Bcrypt.hash_pwd_salt/1)
    |> validate_length(:password, is: 60)
  end
end
