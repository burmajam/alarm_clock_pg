defmodule Repo.Migrations.CreateAlarmClockTable do
  use Ecto.Migration

  def change do
    create table(:alarm_clock, primary_key: false) do
      add :id,     :string,      primary_key: true
      add :alarm,  :string,      null: false
      add :run_at, :timestamp,   null: false

      timestamps updated_at: false
    end
  end
end
