defmodule School.HocTapManager do
  alias School.Repo
  alias School.HocTap
  alias School.Account
  alias School.Week
  alias School.Class
  import Ecto.Query, only: [from: 2]

  def current_week() do 
    Week.start_date(:erlang.localtime())
  end

  defp default_week(map) do
    if map[:week_start_date] == nil do
      Map.put(map, :week_start_date, current_week())
    else
      map
    end
  end

  def new(map, account_id) do
    map = default_week(map)
    account = Repo.get!(Account, account_id)
    HocTap.new(map, account)
    |> Repo.insert!()
  end

  def update(map, account_id) do
    map = default_week(map)
    account = Repo.get!(Account, account_id)
    HocTap.update(map, account)
    |> Repo.update!()
  end

  def delete(map, account_id) do
    account = Repo.get!(Account, account_id)
    HocTap.delete(map, account)
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

  def week(class_id) do
    start_date = current_week()
    query = from e in HocTap,
      where: e.week_start_date == ^start_date and e.class_id == ^class_id,
      order_by: e.day
    Repo.all(query)
  end
end
