defmodule School.HocTap do
  use Ecto.Schema

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
end
