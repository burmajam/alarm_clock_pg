defmodule AlarmClock.PG.Mixfile do
  use Mix.Project

  def project do
    [app: :alarm_clock_pg,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :ecto, :alarm_clock, :postgrex, :calecto]]
  end

  defp deps do
    [
      {:ecto, "~> 1.1.3 or ~> 2.0.0"},
      {:calecto, "~> 0.6"},
      {:postgrex, ">= 0.0.0"},
      {:alarm_clock, path: "~/elixir/alarm_clock"},

      {:earmark, "~> 0.2.1", only: :dev},
      {:ex_doc, "~> 0.11.3", only: :dev}
    ]
  end
end
