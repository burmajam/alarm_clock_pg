defmodule AlarmClock.PG.Model do
  use Ecto.Schema

  @primary_key {:id, :string, []}
  schema "alarm_clock" do
    field :alarm
    field :run_at, Calecto.DateTime

    timestamps()
  end
end
