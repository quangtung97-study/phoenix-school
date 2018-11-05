defmodule School.NeNep do
  use Ecto.Schema
  alias School.NeNep
  import Ecto.Changeset

  schema "nenep" do
    field :day, :integer
    field :week_start_date, :integer
    belongs_to :class, School.Class, foreign_key: :class_id

    field :siso, :integer
    field :dongphuc, :integer
    field :khanquang, :integer
    field :truybai, :integer
    field :chaoco, :integer
    field :vesinh, :integer
    field :bakhong, :integer
    field :shdoi, :integer
    field :tdabc, :integer
    field :nghithucdoi, :integer
    field :ghichu, :string
  end

  defp validate_privilege(hoctap, map, account) do
    check_privilege = fn 
      changeset, true, _ -> changeset
      changeset, _, true -> changeset
      changeset, _, _ -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    hoctap 
    |> cast(map, [])
    |> check_privilege.(account.is_admin, account.is_saodo)
  end

  def new(map, account) do 
    %NeNep{}
    |> validate_privilege(map, account)
    |> School.HocTap.validate_date(map)
  end
end
