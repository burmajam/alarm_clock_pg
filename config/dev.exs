use Mix.Config

config :alarm_clock, :settings,
  name:        MyReminder,
  persister:   AlarmClock.PG

config :logger, :console,
  level:    :debug,
  format:   "$time [$level] $metadata$message\n",
  metadata: [:pid]
