defmodule School.Week do
  import Ecto.Changeset

  def validate_beginning_of_week(cs, field, _options \\ []) do
    validate_change(cs, field, fn _, date ->
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

  def start_date({{year, month, day}, _}) do
    {:ok, date} = Date.new(year, month, day)
    date = Date.add(date, 1 - Date.day_of_week(date))
    date.year * 10000 + date.month * 100 + date.day
  end

  def day_of_week({{year, month, day}, _}) do 
    {:ok, date} = Date.new(year, month, day)
    Date.day_of_week(date)
  end
end
