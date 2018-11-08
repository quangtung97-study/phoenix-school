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
end
