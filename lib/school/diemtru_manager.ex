defmodule School.DiemTruManager do
  import Ecto.Query, only: [from: 2]
  alias School.DiemTru
  alias School.DiemTruThang
  alias School.Repo
  alias School.Class
  alias School.Account

  def week(week_start_date) do
    map = 
      Repo.all(Class)
      |> Stream.map(fn c -> {c.classname, %DiemTru{class_id: c.id, class: c}} end)
      |> Map.new()

    query = from d in DiemTru, 
      where: d.week_start_date == ^week_start_date,
      preload: [:class]
    Repo.all(query)
    |> Enum.reduce(map, fn d, map -> Map.put(map, d.class.classname, d) end)
    |> Map.to_list()
    |> Enum.map(fn {_, diemtru} -> diemtru end)
  end

  def new(map, account_id) do
    account = Repo.get(Account, account_id)
    DiemTru.new(map, account)
    |> Repo.insert!()
  end

  def update(map, account_id) do
    account = Repo.get(Account, account_id)
    DiemTru.update(map, account)
    |> Repo.update!()
  end

  def delete(map, account_id) do
    account = Repo.get(Account, account_id)
    DiemTru.delete(map, account)
    |> Repo.delete!()
  end
end
