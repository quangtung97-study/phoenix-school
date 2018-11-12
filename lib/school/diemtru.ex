defmodule School.DiemTru do
  use Ecto.Schema
  import Ecto.Changeset
  alias School.DiemTru

  schema "diemtru" do
    field :week_start_date, :integer
    belongs_to :class, School.Class, foreign_key: :class_id
    field :diemtru, :integer
  end

  defp validate_privilege(diemtru, account) do
    check_privilege = fn 
      changeset, true -> changeset
      changeset, _ -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    diemtru
    |> cast(%{}, [])
    |> check_privilege.(account.is_admin)
  end

  defp validate_values(diemtru, map) do
    diemtru
    |> cast(map, [:class_id, :diemtru])
    |> validate_required([:class_id, :diemtru])
  end

  defp validate_date(diemtru, map) do
    diemtru
    |> cast(map, [:week_start_date])
    |> School.Week.validate_beginning_of_week(:week_start_date)
  end

  def new(map, account) do
    %DiemTru{}
    |> validate_privilege(account)
    |> validate_date(map)
    |> validate_values(map)
  end

  def update(map, account) do
    %DiemTru{id: map[:id]}
    |> validate_privilege(account)
    |> validate_date(map)
    |> validate_values(map)
  end

  def delete(map, account) do
    %DiemTru{id: map[:id]}
    |> validate_privilege(account)
  end
end
