defmodule School.NeNepTest do
  use ExUnit.Case, async: true
  alias School.Account
  alias School.NeNep
  import Ecto.Changeset

  setup do
    account = %Account{is_admin: true, is_saodo: true}
    map = %{
      class_id: 5,
      day: 2,
      week_start_date: 20181105,

      siso: 20,
      dongphuc: 20,
      khanquang: 20,
      truybai: 20,

      chaoco: 20,
      vesinh: 20,
      bakhong: 20,
      shdoi: 20,

      tdvuichoi: 20,
      nghithucdoi: 20,
      ghichu: "tung quang",
    }
    %{map: map, account: account}
  end

  test "validate privilege", context do
    account = %{context.account | is_admin: false, is_saodo: false}
    map = context.map
    {:error, _cs} = 
      NeNep.new(map, account)
      |> apply_action(:insert)

    account = %{context.account | is_admin: true, is_saodo: false}
    {:ok, _nenep} = 
      NeNep.new(map, account)
      |> apply_action(:insert)
  end
end
