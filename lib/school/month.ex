defmodule School.Month do
  import Ecto.Changeset, only: [validate_change: 3]
  def validate_month(cs, field) do
    validate_change(cs, field, fn ^field, month_value ->
      year = div(month_value, 100)
      month = month_value - year * 100
      case Date.new(year, month, 1) do
        {:ok, _} -> []
        _ -> [{field, "Invalid month"}]
      end
    end)
  end

  def start_date(month_value) do
    year = div(month_value, 100)
    month = month_value - year * 100
    {:ok, date} = Date.new(year, month, 1)
    date = Date.add(date, 6)
    date = Date.add(date, 1 - Date.day_of_week(date))
    date.year * 10000 + date.month * 100 + date.day
  end

  def all_week(month_value) do
    year = div(month_value, 100)
    month = month_value - year * 100
    {:ok, date} = Date.new(year, month, 1)
    date = Date.add(date, 6)
    Date.add(date, 1 - Date.day_of_week(date))
    |> Stream.iterate(&Date.add(&1, +7))
    |> Stream.take_while(&(&1.month == month))
    |> Enum.map(fn d ->
      d.year * 10000 + d.month * 100 + d.day
    end)
  end

  def nearest_months({{year, month, _}, _}, n) do
    {:ok, date} = Date.new(year, month, 1)
    date
    |> Stream.iterate(fn d ->
      prev = Date.add(d, -1)
      day_count = Date.days_in_month(prev)
      Date.add(d, -day_count)
    end)
    |> Stream.take(n)
    |> Enum.map(fn d ->
      d.year * 100 + d.month
    end)
  end

  def nearest_months(n) do
    nearest_months(:erlang.localtime(), n)
  end
end
