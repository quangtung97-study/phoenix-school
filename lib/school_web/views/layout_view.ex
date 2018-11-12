defmodule SchoolWeb.LayoutView do
  use SchoolWeb, :view

  def home_active?(:home), do: "active"

  def home_active?(_), do: ""

  def hoctap_active?(:hoctap), do: "active"

  def hoctap_active?(_), do: ""

  def nenep_active?(:nenep), do: "active"

  def nenep_active?(_), do: ""

  def diemtru_active?(:diemtru), do: "active"

  def diemtru_active?(_), do: ""

  def manage_active?(:manage), do: "active"

  def manage_active?(_), do: ""

  def report_active?(:report), do: "active"

  def report_active?(_), do: ""
end
