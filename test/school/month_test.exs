defmodule School.MonthTest do
  use ExUnit.Case, async: true
  alias School.Month 
  import Ecto.Changeset

  test "month start_date" do
    assert Month.start_date(201811) == 20181105
  end

  test "all week" do
    assert Month.all_week(201811) == 
      [20181105, 20181112, 20181119, 20181126]
  end

  test "nearest months" do
    compared = [201802, 201801, 201712, 201711, 201710]
    assert Month.nearest_months({{2018, 2, 3}, nil}, 5) == compared
  end

  test "validate month" do 
    map = %{month: 201823}

    {:error, cs} = 
      %School.DiemTruThang{}
      |> cast(map, [:month])
      |> validate_required([:month])
      |> Month.validate_month(:month)
      |> apply_action(:insert)
    assert cs.errors == [month: {"Invalid month", []}]

    map = %{month: 201811}
    {:ok, _} = 
      %School.DiemTruThang{}
      |> cast(map, [:month])
      |> validate_required([:month])
      |> Month.validate_month(:month)
      |> apply_action(:insert)
  end
end
