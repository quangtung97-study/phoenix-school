defmodule SchoolWeb.NenepView do
  use SchoolWeb, :view

  defp class_active?(c, class) do
    if c.id == class.id do
      "active"
    else
      ""
    end
  end

  defp start_date_active?(d, week_start_date) do
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
      {date, _} = Integer.parse(params["week_start_date"])
      School.Week.start_date(date)
    end
  end

  defp put_nil(map, params, name) do
    case Integer.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, num)
      :error -> Map.put(map, name, nil)
    end
  end

  defp put_float(map, params, name) do
    case Float.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, round(num * 10))
      :error -> Map.put(map, name, 0)
    end
  end

  defp put_string(map, params, name) do
    case params["#{name}"] do
      nil -> Map.put(map, name, "")
      s when is_binary(s) -> Map.put(map, name, s)
    end
  end

  def param_map(params) do
    %{}
    |> put_nil(params, :id)
    |> put_nil(params, :class_id)
    |> put_nil(params, :day)
    |> put_nil(params, :week_start_date)

    |> put_float(params, :siso)
    |> put_float(params, :khanquang)
    |> put_float(params, :dongphuc)
    |> put_float(params, :vesinh)

    |> put_float(params, :chaoco)
    |> put_float(params, :truybai)
    |> put_float(params, :bakhong)
    |> put_float(params, :shdoi)

    |> put_float(params, :tdvuichoi)
    |> put_float(params, :nghithucdoi)
    |> put_string(params, :ghichu)
  end
end
