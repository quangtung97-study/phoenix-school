defmodule School.Schema.LopTruong do
  use Ecto.Schema

  @primary_key false
  schema "loptruong" do
    field :username, :string, primary_key: true
    field :classname, :string, primary_key: true
  end
end
