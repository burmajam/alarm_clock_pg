defmodule AlarmClock.PG.Mixfile do
  use Mix.Project

  def project do
    [app: :alarm_clock_pg,
     version: "0.0.5",
     elixir: "~> 1.3",
     package: package(),
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :ecto, :alarm_clock, :postgrex, :calecto]]
  end

  defp deps do
    [
      {:ecto, "~> 1.1.3 or ~> 2.1"},
      {:calecto, "~> 0.6"},
      {:postgrex, ">= 0.0.0"},
      {:alarm_clock, "~> 0.1.0"},

      {:ex_doc, ">= 0.11.4", only: [:dev]},
      {:earmark, ">= 0.0.0", only: [:dev]},
    ]
  end

  defp package do
    %{
       maintainers: ["Milan Burmaja"],
       links: %{ "GitHub" => "https://github.com/burmajam/alarm_clock_pg"},
       licenses: ["MIT"],
       files: ~w(lib mix.exs README*) }
  end

  defp description do
    """
    Postgres adapter for :alarm_clock
    """
  end
end
