defmodule School.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "report" do
    field :week_start_date, :integer
    field :data, :map
  end

  defp validate_privilege(changeset, account) do
    check_privilege = fn 
      changeset, true -> changeset
      changeset, false -> 
        add_error(changeset, :privilege, "Does not have the privilege")
    end

    changeset
    |> cast(%{}, [])
    |> check_privilege.(account.is_admin)
  end

  defp new_changeset(report, map) do
    report
    |> cast(map, [:week_start_date, :data])
    |> validate_required([:week_start_date, :data])
    |> School.Week.validate_beginning_of_week(:week_start_date)
    |> unique_constraint(:week_start_date)
  end

  def new(week_start_date, data, account) do
    map = %{
      week_start_date: week_start_date,
      data: data
    }

    %School.Report{}
    |> validate_privilege(account)
    |> new_changeset(map)
  end

  defp update_changeset(report, map) do
    report
    |> cast(map, [:data])
    |> validate_required([:data])
  end

  def update(report_id, data, account) do
    map = %{
      data: data
    }
    %School.Report{id: report_id}
    |> validate_privilege(account)
    |> update_changeset(map)
  end

  def delete(report_id, account) do
    %School.Report{id: report_id}
    |> validate_privilege(account)
  end
end
