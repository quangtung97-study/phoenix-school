defmodule School.WeekTest do
  use ExUnit.Case, async: true
  alias School.Week

  test "start date number" do
    year = 2018
    month = 11
    day = 6
    assert Week.start_date({{year, month, day}, nil}) == 20181105
  end

  test "day_of_week" do 
    assert Week.day_of_week({{2018, 11, 4}, nil}) == 7
  end

  test "nearest start dates" do
    year = 2018
    month = 11
    day = 8
    assert Week.nearest_start_dates({{year, month, day}, nil}, 3) ==
      [20181105, 20181029, 20181022]
  end
end
