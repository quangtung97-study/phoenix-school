defmodule School.Class do
  use Ecto.Schema
  alias School.Class
  import Ecto.Changeset

  schema "class" do
    field :classname, :string
    has_one :loptruong, School.Account
    has_many :hoctap, School.HocTap
    has_many :nenep, School.NeNep
  end

  defp new_changeset(class, map) do
    class
    |> cast(map, [:classname])
    |> validate_required([:classname])
    |> validate_length(:classname, min: 2, max: 10)
  end

  def new(classname) do
    new_changeset(%Class{}, %{classname: classname})
  end

  def delete(class_id) do
    %Class{id: class_id}
  end
end
