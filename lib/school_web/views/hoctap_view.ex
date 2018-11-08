defmodule SchoolWeb.HoctapView do
  use SchoolWeb, :view

  def class_active?(c, class) do
    if c.id == class.id do
      "active"
    else
      ""
    end
  end

  def start_date_active?(d, week_start_date) do
    if d == week_start_date do
      "active"
    else
      ""
    end
  end

  def get_class(params, classes) do
    if params["class_id"] == nil do
      {:ok, e} = Enum.fetch(classes, 0)
      e
    else
      {id, _} = Integer.parse(params["class_id"])
      Enum.find(classes, fn c -> c.id == id end)
    end
  end

  def get_week_start_date(params) do 
    if params["week_start_date"] == nil do
      School.Week.current_week()
    else
      {start_date, _} = Integer.parse(params["week_start_date"])
      start_date
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
    |> put(params, :id)
    |> put(params, :class_id)
    |> put(params, :day)
    |> put_nil(params, :week_start_date)
    |> put(params, :diemgioi)
    |> put(params, :diemkha)
    |> put(params, :diemtb)
    |> put(params, :diemyeu)
    |> put(params, :diemkem)
    |> put(params, :giotot)
    |> put(params, :giokha)
    |> put(params, :giotb)
  end
end
