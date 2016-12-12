defmodule AlarmClockPgTest do
  use ExUnit.Case
  doctest AlarmClock.PG

  Code.require_file("test/repo.exs")

  setup_all do
    Repo.start_link
    :ok
  end

  test "the truth" do
    {:ok, pid} = AlarmClock.PG.start_link Repo
    {:ok, alarm_clock} = AlarmClock.start persister: AlarmClock.PG
    assert 1 + 1 == 2
  end
end
