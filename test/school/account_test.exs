defmodule School.AccountTest do
  use ExUnit.Case, async: true
  alias School.Account
  import Ecto.Changeset

  setup do
    cs = Account.new("tung", "quangtung")
    {:ok, tung} = apply_action(cs, :insert)
    %{tung: tung}
  end

  test "password correct?", context do
    tung = context.tung
    assert Account.password_correct?(tung, "quangtung") == true
    assert Account.password_correct?(tung, "abcd") == false
  end

  test "change password old password is not correct", context do 
    tung = context.tung
    cs = Account.change_password(tung, "tung", "newpass")
    {:error, cs} = apply_action(cs, :insert)
    assert cs.errors == [password: {"Password is not correct", []}]
  end

  test "change password ok", context do 
    tung = context.tung
    cs = Account.change_password(tung, "quangtung", "newpass")
    {:ok, tung} = apply_action(cs, :insert)
    assert Account.password_correct?(tung, "newpass") == true
  end

  test "add privilege admin", context do
    tung = context.tung

    cs = Account.add_privilege(tung, :admin)
    {:ok, tung} = apply_action(cs, :insert)

    assert tung.is_admin == true
  end
end
