use Mix.Config

config :alarm_clock_pg, ecto_repos: [Repo]

config :alarm_clock, :settings,
  name:        MyReminder,
  persister:   AlarmClock.PG

config :alarm_clock_pg, Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "alarm_clock_pg_test",
  pool_size: 10

config :logger, :console,
  level:    :debug,
  format:   "$time [$level] $metadata$message\n",
  metadata: [:pid]
