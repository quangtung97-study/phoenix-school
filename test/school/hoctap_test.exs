defmodule Shool.HocTapTest do
  use ExUnit.Case, async: true
  alias School.HocTap
  alias School.Account
  import Ecto.Changeset

  setup do
    account = %Account{is_admin: true, is_loptruong: false, class_id: 5}
    map = %{
      class_id: 5,
      day: 2,
      week_start_date: 20181105,
      current_week: 20181105,

      diemgioi: 5,
      diemkha: 3,
      diemtb: 2,
      diemyeu: 0,
      diemkem: 1,

      giotot: 6,
      giokha: 3,
      giotb: 1,
    }
    %{map: map, account: account}
  end

  test "vallidate privilege is admin", context do
    account = %Account{is_admin: true, is_loptruong: false, class_id: 5}

    map = %{context.map|class_id: 10}
    {:ok, _} = 
      HocTap.new(map, account)
      |> apply_action(:insert)
  end

  test "validate privilege is loptruong", context do 
    account = %Account{is_admin: false, is_loptruong: true, class_id: 5}

    map = %{context.map|class_id: 10}
    {:error, cs} = 
      HocTap.new(map, account)
      |> apply_action(:insert)
    assert cs.errors == [privilege: {"Does not have the privilege", []}]

    map = %{context.map|current_week: 20181112}
    {:error, cs} = 
      HocTap.new(map, account)
      |> apply_action(:insert)
    assert cs.errors == [privilege: {"Does not have the privilege", []}]

    map = %{context.map|class_id: 5}
    {:ok, _} = 
      HocTap.new(map, account)
      |> apply_action(:insert)
  end

  test "validate week_start_date and day", context do
    account = context.account

    map = %{context.map|week_start_date: 20181107}
    {:error, _cs} =
      HocTap.new(map, account)
      |> apply_action(:insert)

    map = %{context.map|day: 0}
    {:error, _cs} =
      HocTap.new(map, account)
      |> apply_action(:insert)

    map = context.map
    {:ok, _hoctap} =
      HocTap.new(map, account)
      |> apply_action(:insert)
  end

  test "validate diemgoi, diemkha, ...", context do
    account = context.account

    map = %{context.map|diemgioi: nil}
    {:error, _cs} =
      HocTap.new(map, account)
      |> apply_action(:insert)

    map = %{context.map|diemgioi: false}
    {:error, _cs} =
      HocTap.new(map, account)
      |> apply_action(:insert)

    map = %{context.map|diemgioi: -1}
    {:error, _cs} =
      HocTap.new(map, account)
      |> apply_action(:insert)
  end
end
