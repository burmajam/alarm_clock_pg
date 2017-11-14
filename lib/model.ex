defmodule AlarmClock.PG.Model do
  use Ecto.Schema

  @table_name Application.get_env(:alarm_clock_pg, :table, "alarm_clock")

  @primary_key {:id, :string, []}
  schema @table_name do
    field :alarm
    field :run_at, :naive_datetime

    timestamps updated_at: false
  end
end
