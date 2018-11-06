defmodule SchoolWeb.LayoutView do
  use SchoolWeb, :view

  def homepage_link_active?(:home), do: "active"

  def homepage_link_active?(_), do: ""
end
