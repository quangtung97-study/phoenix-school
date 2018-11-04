defmodule School.Class do
  use Ecto.Schema

  schema "class" do
    field :classname, :string
    has_one :loptruong, School.Account
    has_many :hoctap, School.HocTap
    has_many :nenep, School.NeNep
  end
end
