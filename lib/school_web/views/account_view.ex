defmodule SchoolWeb.AccountView do
  use SchoolWeb, :view

  defp privilege_string_case(true, _, _), do: "quản trị"

  defp privilege_string_case(false, true, false), do: "sao đỏ"

  defp privilege_string_case(false, false, true), do: "lớp trưởng"

  defp privilege_string_case(false, true, true), do: "sao đỏ, lớp trưởng"

  defp privilege_string_case(_, _, _), do: "không có"

  def privilege_string(account) do
    privilege_string_case(account.is_admin, 
      account.is_saodo, account.is_loptruong)
  end
end
