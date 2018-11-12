defmodule School.DiemTruThang do
  use Ecto.Schema
  import Ecto.Changeset
  alias School.DiemTruThang
  alias School.Month

  schema "diemtruthang" do
    field :month, :integer
    belongs_to :class, School.Class, foreign_key: :class_id
    field :diemtru, :integer
    field :diemcong, :integer
  end

  defp validate_month(changeset, map) do
    changeset
    |> cast(map, [:month])
    |> validate_required([:month])
    |> Month.validate_month(:month)
  end

  defp validate_values(changeset, map) do
    changeset
    |> cast(map, [:class_id, :diemtru, :diemcong])
    |> validate_required([:class_id, :diemtru, :diemcong])
  end

  defp validate_privilege(changeset, account) do
    check_privilege = fn 
      changeset, true -> changeset
      changeset, _ -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    changeset
    |> cast(%{}, [])
    |> check_privilege.(account.is_admin)
  end

  def new(map, account) do
    %DiemTruThang{}
    |> validate_privilege(account)
    |> validate_month(map)
    |> validate_values(map)
  end

  def update(map, account) do
    %DiemTruThang{id: map[:id]}
    |> validate_privilege(account)
    |> validate_month(map)
    |> validate_values(map)
  end

  def delete(map, account) do
    %DiemTruThang{id: map[:id]}
    |> validate_privilege(account)
  end
end
