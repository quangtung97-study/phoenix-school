defmodule School.ReportManager do
  import Ecto.Query, only: [from: 2]
  alias School.Report
  alias School.Week
  alias School.Repo
  alias School.Account

  def list(:report, n) do
  end

  def list(:status, n) do 
    map =
      Week.nearest_start_dates(n)
      |> Stream.map(&{&1, false})
      |> Map.new()

    start_date = Week.start_date_since_weeks_ago(n)
    query = from r in Report,
      where: r.week_start_date >= ^start_date,
      select: r.week_start_date

    Repo.all(query)
    |> Enum.reduce(map, &Map.put(&2, &1, true))
    |> Map.to_list()
    |> Enum.reverse()
  end

  def new(map, account_id) do
    account = Repo.get!(Account, account_id)
    Report.new(map[:week_start_date], %{tung: "nothing"}, account)
    |> Repo.insert!()
  end
end
