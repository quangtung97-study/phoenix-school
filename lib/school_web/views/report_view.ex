defmodule SchoolWeb.ReportView do
  use SchoolWeb, :view

  defp put_nil(map, params, name) do
    case Integer.parse(params["#{name}"]) do
      {num, _} -> Map.put(map, name, num)
      :error -> Map.put(map, name, nil)
    end
  end

  def param_map(params) do
    %{}
    |> put_nil(params, :week_start_date)
  end
end
