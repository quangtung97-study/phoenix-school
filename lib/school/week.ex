defmodule School.Week do
  import Ecto.Changeset

  def validate_beginning_of_week(cs, field) do
    validate_change(cs, field, fn ^field, date ->
      year = div(date, 10000)
      date = date - year * 10000
      month = div(date, 100)
      day = date - month * 100
      {:ok, date} = Date.new(year, month, day)
      case Date.day_of_week(date) do
        1 -> []
        _ -> [{field, "Expected Monday"}]
      end
    end)
  end

  def day_of_week({{year, month, day}, _}) do 
    {:ok, date} = Date.new(year, month, day)
    Date.day_of_week(date)
  end

  def start_date({{year, month, day}, _}) do
    {:ok, date} = Date.new(year, month, day)
    date = Date.add(date, 1 - Date.day_of_week(date))
    date.year * 10000 + date.month * 100 + date.day
  end

  def start_date(day_value) do
    year = div(day_value, 10000)
    day_value = day_value - year * 10000
    month = div(day_value, 100)
    day = day_value - month * 100
    start_date({{year, month, day}, nil})
  end

  def current_week() do 
    start_date(:erlang.localtime())
  end

  def nearest_start_dates({{year, month, day}, _}, n) do
    {:ok, date} = Date.new(year, month, day)
    date = Date.add(date, 1 - Date.day_of_week(date))

    date
    |> Stream.iterate(&Date.add(&1, -7))
    |> Stream.map(fn d ->
      d.year * 10000 + d.month * 100 + d.day
    end)
    |> Enum.take(n)
  end

  def nearest_start_dates(n) do
    nearest_start_dates(:erlang.localtime(), n)
  end

  def start_date_since_weeks_ago({{year, month, day}, _}, week_count) do
    {:ok, date} = Date.new(year, month, day)
    date = 
      date
      |> Date.add(1 - Date.day_of_week(date))
      |> Date.add(-7 * week_count)
    date.year * 10000 + date.month * 100 + date.day
  end

  def start_date_since_weeks_ago(week_count) do
    start_date_since_weeks_ago(:erlang.localtime(), week_count)
  end
end
