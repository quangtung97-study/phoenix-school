defmodule School.NeNep do
  use Ecto.Schema
  alias School.NeNep
  import Ecto.Changeset

  schema "nenep" do
    field :day, :integer
    field :week_start_date, :integer
    belongs_to :class, School.Class, foreign_key: :class_id

    field :siso, :integer
    field :khanquang, :integer
    field :dongphuc, :integer
    field :vesinh, :integer

    field :chaoco, :integer
    field :truybai, :integer
    field :bakhong, :integer
    field :shdoi, :integer

    field :tdvuichoi, :integer
    field :nghithucdoi, :integer
    field :ghichu, :string
  end

  defp validate_privilege(hoctap, map, account) do
    check_privilege = fn 
      changeset, true, _, _, _ -> changeset
      changeset, _, true, date, date -> changeset
      changeset, _, _, _, _ -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    hoctap 
    |> cast(map, [:class_id])
    |> validate_required([:class_id])
    |> check_privilege.(
      account.is_admin, account.is_saodo,
      map[:current_week], map[:week_start_date]
    )
  end

  defp validate_values(hoctap, map) do
    hoctap
    |> cast(map, [
      :siso, :khanquang, :dongphuc, :vesinh, 
      :chaoco, :truybai, :bakhong, :shdoi, 
      :tdvuichoi, :nghithucdoi, :ghichu
    ], empty_values: [])
    |> validate_required([
      :siso, :khanquang, :dongphuc, :vesinh, 
      :chaoco, :truybai, :bakhong, :shdoi, 
      :tdvuichoi, :nghithucdoi
    ])
    |> validate_length(:ghichu, max: 100)

    |> validate_number(:siso, greater_than_or_equal_to: 0)
    |> validate_number(:khanquang, greater_than_or_equal_to: 0)
    |> validate_number(:dongphuc, greater_than_or_equal_to: 0)
    |> validate_number(:vesinh, greater_than_or_equal_to: 0)

    |> validate_number(:chaoco, greater_than_or_equal_to: 0)
    |> validate_number(:truybai, greater_than_or_equal_to: 0)
    |> validate_number(:bakhong, greater_than_or_equal_to: 0)
    |> validate_number(:shdoi, greater_than_or_equal_to: 0)

    |> validate_number(:tdvuichoi, greater_than_or_equal_to: 0)
    |> validate_number(:nghithucdoi, greater_than_or_equal_to: 0)
  end

  def new(map, account) do 
    %NeNep{}
    |> validate_privilege(map, account)
    |> School.HocTap.validate_date(map)
    |> validate_values(map)
  end

  def update(map, account) do 
    %NeNep{id: map.id}
    |> validate_privilege(map, account)
    |> School.HocTap.validate_date(map)
    |> validate_values(map)
  end

  def delete(map, account) do
    %NeNep{id: map.id}
    |> validate_privilege(map, account)
  end
end
