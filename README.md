# AlarmClockPg

Postgres adapter for alarm_clock persistence

## Installation

1. Add `alarm_clock_pg` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:alarm_clock_pg, "~> 0.0.1"}]
  end
  ```

2. Ensure `alarm_clock_pg` is started before your application:

  ```elixir
  def application do
    [applications: [:alarm_clock_pg]]
  end
  ```
