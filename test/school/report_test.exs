defmodule School.ReportTest do
  use ExUnit.Case, async: true
  alias School.Report
  alias School.Account
  import Ecto.Changeset

  setup do
    %{
      start_date: 20181105,
      data: %{tung: 100},
      account: %Account{is_admin: true},
    }
  end

  test "privilege", context do
    start_date = context.start_date
    data = context.data

    account = %Account{is_admin: false}
    {:error, cs} = 
      Report.new(start_date, data, account)
      |> apply_action(:insert)
    assert cs.errors == [{:privilege, {"Does not have the privilege", []}}]

    account = %Account{is_admin: true}
    {:ok, report} = 
      Report.new(start_date, data, account)
      |> apply_action(:insert)

    assert report.data == data
    assert report.week_start_date == start_date
  end

  test "validate_beginning_of_week", context do
    data = context.data
    account = context.account

    start_date = 20181108
    {:error, cs} = 
      Report.new(start_date, data, account)
      |> apply_action(:insert)
    assert cs.errors == [{:week_start_date, {"Expected Monday", []}}]

    start_date = 20181105
    {:ok, _} = 
      Report.new(start_date, data, account)
      |> apply_action(:insert)
  end
end
