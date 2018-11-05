defmodule School.HocTapManager do
  alias School.Repo
  alias School.HocTap
  alias School.Account
  alias School.Week

  defp default_week(map) do
    if map[:week_start_date] == nil do
      %{map|week_start_date: Week.start_date(:erlang.localtime())}
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
    HocTap.update(map.id, map, account)
    |> Repo.update!()
  end
end
