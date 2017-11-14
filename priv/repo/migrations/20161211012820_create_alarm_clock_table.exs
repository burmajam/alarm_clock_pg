defmodule Repo.Migrations.CreateAlarmClockTable do
  use Ecto.Migration

  @table_name Application.get_env(:alarm_clock_pg, :table, "alarm_clock") |> String.to_atom

  def change do
    create table(@table_name, primary_key: false) do
      add :id,     :string,      primary_key: true
      add :alarm,  :text,        null: false
      add :run_at, :timestamp,   null: false

      timestamps updated_at: false
    end
  end
end
