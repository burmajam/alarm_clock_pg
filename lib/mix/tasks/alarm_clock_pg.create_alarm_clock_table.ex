defmodule Mix.Tasks.AlarmClock.Pg.CreateAlarmClockTable do
  use Mix.Task
  import Mix.Generator
  import Mix.Ecto

  @migration_name "CreateAlarmClockTable"
  @shortdoc "Creates alarm_clock table"
  @preferred_cli_env :dev

  def run(args) do
    path = "#{Mix.Project.app_path}/priv/repo/migrations/"
    Mix.Task.run "app.start", args
    repo = parse_repo(args) |> hd
    filename = "#{timestamp()}_create_alarm_clock_table.exs"
    file = Path.join(path, filename)
    create_directory path
    create_file file, migration_template(mod:
                        Module.concat([repo, Migrations, @migration_name]))
  end

  defp timestamp do
    Calendar.DateTime.now_utc
    |> Calendar.DateTime.Format.rfc3339(0)
    |> String.replace(~r/[^0-9]/, "")
  end

  embed_template :migration, """
  defmodule <%= inspect @mod %> do
    use Ecto.Migration

    def change do
      create table(:alarm_clock, primary_key: false) do
        add :id,     :string,            primary_key: true
        add :alarm,  :text,              null:        false
        add :run_at, :calendar_datetime, null:        false

        timestamps updated_at: false
      end
    end
  end
  """
end
