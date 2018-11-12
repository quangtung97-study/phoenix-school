defmodule SchoolWeb.DiemtruView do
  use SchoolWeb, :view

  defp date_active?(date, date), do: "active"

  defp date_active?(_, _), do: ""

  def get_week_start_date(params) do 
    if params["week_start_date"] == nil do
      School.Week.current_week()
    else
      {date, _} = Integer.parse(params["week_start_date"])
      School.Week.start_date(date)
    end
  end

  defp put(map, params, name) do
    case Integer.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, num)
      :error -> Map.put(map, name, 0)
    end
  end

  defp put_nil(map, params, name) do
    case Integer.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, num)
      :error -> Map.put(map, name, nil)
    end
  end

  def param_map(params) do
    %{}
    |> put_nil(params, :id)
    |> put_nil(params, :class_id)
    |> put_nil(params, :week_start_date)
    |> put(params, :diemtru)
  end
end
