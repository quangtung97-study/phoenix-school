defmodule School.Repo.Migrations.Init do
  use Ecto.Migration

  def up do
    create table(:class) do
      add :classname, :varchar, size: 10, null: false
    end

    create unique_index(:class, [:classname])

    create table(:account) do
      add :username, :varchar, size: 50, null: false
      add :password, :char, size: 60, null: false
      add :is_admin, :boolean, default: false
      add :is_saodo, :boolean, default: false
      add :is_loptruong, :boolean, default: false
      add :class_id, references(:class)
    end

    create unique_index(:account, [:username])

    create table(:hoctap) do 
      add :day, :int, null: false
      add :week_start_date, :int, null: false
      add :class_id, references(:class), null: false

      add :diemgioi, :int, null: false
      add :diemkha, :int, null: false
      add :diemtb, :int, null: false
      add :diemyeu, :int, null: false
      add :diemkem, :int, null: false

      add :giotot, :int, null: false
      add :giokha, :int, null: false
      add :giotb, :int, null: false
    end

    create unique_index(:hoctap, [:day, :week_start_date, :class_id])

    create table(:nenep) do
      add :day, :int, null: false
      add :week_start_date, :int, null: false
      add :class_id, references(:class), null: false

      add :siso, :int, null: false
      add :dongphuc, :int, null: false
      add :khanquang, :int, null: false
      add :truybai, :int, null: false
      add :chaoco, :int, null: false
      add :vesinh, :int, null: false
      add :bakhong, :int, null: false
      add :shdoi, :int, null: false
      add :tdabc, :int, null: false
      add :nghithucdoi, :int, null: false
      add :ghichu, :varchar, size: 100, null: false
    end

    create unique_index(:nenep, [:day, :week_start_date, :class_id])

    create table(:report) do
      add :week_start_date, :int, null: false
      add :data, :json, null: false
    end

    create unique_index(:report, [:week_start_date])

    flush()

    {:ok, admin} = 
      School.Account.new("admin", "admin")
      |> School.Repo.insert()

    admin 
    |> School.Account.add_privilege(:admin)
    |> School.Repo.update()
  end

  def down do 
    drop table(:report)
    drop table(:nenep)
    drop table(:hoctap)
    drop table(:account)
    drop table(:class)
  end
end
