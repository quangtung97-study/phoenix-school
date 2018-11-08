defmodule School.HocTap do
  use Ecto.Schema
  alias School.HocTap
  import Ecto.Changeset

  schema "hoctap" do
    field :day, :integer
    field :week_start_date, :integer
    belongs_to :class, School.Class, foreign_key: :class_id

    field :diemgioi, :integer
    field :diemkha, :integer
    field :diemtb, :integer
    field :diemyeu, :integer
    field :diemkem, :integer

    field :giotot, :integer
    field :giokha, :integer
    field :giotb, :integer
  end

  defp validate_privilege(hoctap, map, account) do
    check_privilege = fn 
      changeset, true, _, _, _, _, _ -> changeset
      changeset, _, true, id, id, date, date -> changeset
      changeset, _, _, _, _, _, _ -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    hoctap 
    |> cast(map, [:class_id])
    |> check_privilege.(
      account.is_admin, account.is_loptruong, 
      account.class_id, map[:class_id],
      map[:current_week], map[:week_start_date]
    )
    |> validate_required([:class_id])
  end

  def validate_date(hoctap, map) do
    hoctap
    |> cast(map, [:day, :week_start_date])
    |> validate_required([:day, :week_start_date])
    |> validate_inclusion(:day, 1..6)
    |> School.Week.validate_beginning_of_week(:week_start_date)
  end

  defp validate_diem(hoctap, map) do
    hoctap
    |> cast(map, [:diemgioi, :diemkha, :diemtb,
      :diemyeu, :diemkem, :giotot, :giokha, :giotb])
    |> validate_required([:diemgioi, :diemkha, :diemtb,
      :diemyeu, :diemkem, :giotot, :giokha, :giotb])
    |> validate_number(:diemgioi, greater_than_or_equal_to: 0)
    |> validate_number(:diemkha, greater_than_or_equal_to: 0)
    |> validate_number(:diemtb, greater_than_or_equal_to: 0)
    |> validate_number(:diemyeu, greater_than_or_equal_to: 0)
    |> validate_number(:diemkem, greater_than_or_equal_to: 0)
    |> validate_number(:giotot, greater_than_or_equal_to: 0)
    |> validate_number(:giokha, greater_than_or_equal_to: 0)
    |> validate_number(:giotb, greater_than_or_equal_to: 0)
  end

  def new(map, account) do
    %HocTap{}
    |> validate_privilege(map, account)
    |> validate_date(map)
    |> validate_diem(map)
  end

  def update(map, account) do
    %HocTap{id: map.id}
    |> validate_privilege(map, account)
    |> validate_date(map)
    |> validate_diem(map)
  end

  def delete(map, account) do
    %HocTap{id: map.id}
    |> validate_privilege(map, account)
  end
end
