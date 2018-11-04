defmodule School.NeNep do
  use Ecto.Schema

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
end
