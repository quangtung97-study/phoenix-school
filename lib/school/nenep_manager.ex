defmodule School.NeNepManager do
  alias School.Repo
  alias School.NeNep
  alias School.Account
  alias School.Week
  alias School.Class
  import Ecto.Query, only: [from: 2]

  defp default_week(map) do
    case map[:week_start_date] do
      nil -> 
        Map.put(map, :week_start_date, Week.current_week())
      _ -> 
        map
    end
  end

  def new(map, account_id) do
    map = default_week(map)
    account = Repo.get!(Account, account_id)
    NeNep.new(map, account)
    |> Repo.insert!()
  end

  def update(map, account_id) do
    map = default_week(map)
    account = Repo.get!(Account, account_id)
    NeNep.update(map, account)
    |> Repo.update!()
  end

  def delete(map, account_id) do
    account = Repo.get!(Account, account_id)
    NeNep.delete(map, account)
    |> Repo.delete!()
  end

  def class(:nil), do: nil
  
  def class(class_id) do
    Repo.get(Class, class_id)
  end

  def classes() do
    query = from c in Class,
      order_by: c.classname
    Repo.all(query)
  end

  def week(class_id, start_date \\ Week.current_week()) do
    query = from e in NeNep,
      where: e.week_start_date == ^start_date and e.class_id == ^class_id,
      order_by: e.day
    Repo.all(query)
  end
end
