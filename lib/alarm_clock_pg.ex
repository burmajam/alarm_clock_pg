defmodule AlarmClock.PG do
  @behaviour AlarmClock.Persister
  use        GenServer
  import     Ecto.Query
  alias      AlarmClock.PG.Model
  require    Logger

  def start_link(repo_module),
    do: GenServer.start_link __MODULE__, repo_module, name: __MODULE__

  def load_saved_alarms,
    do: GenServer.call __MODULE__, :load_saved_alarms

  def save_alarm({:alarm, _call_type, _target_pid, _msg, _opts, _attempt}=alarm),
    do: GenServer.call __MODULE__, {:save_alarm, alarm}

  def delete_alarm(alarm_id),
    do: GenServer.call __MODULE__, {:delete_alarm, alarm_id}

  def init(repo),
    do: {:ok, repo}

  def handle_call(:load_saved_alarms, _from, repo) do
    query = from m in Model,
              select: {m.id, m.alarm}
    result = repo.all(query)
               |> Enum.map(fn {id, alarm} ->
                    {id, alarm |> :base64.decode |> :erlang.binary_to_term |> AlarmClock.Persister.get_runnable_alarm} 
                  end)
    {:reply, result, repo}
  end

  def handle_call({:save_alarm, {:alarm, call_type, target_pid, msg, opts, attempt}=alarm}, _from, repo) do
    alarm_id = :crypto.hash(:sha256, inspect(alarm)) |> :base64.encode
    {alarm, at} = if Keyword.get(opts, :at) do
      {alarm |> :erlang.term_to_binary |> :base64.encode, Keyword.get(opts, :at)}
    else
      in_ms = Keyword.fetch! opts, :in
      at = AlarmClock.Persister.calculate_time(in_ms)
      opts  = opts ++ [at: at]
      alarm = {:alarm, call_type, target_pid, msg, opts, attempt} |> :erlang.term_to_binary |> :base64.encode
      {alarm, at}
    end 
    repo.insert! %Model{id: alarm_id, alarm: alarm, run_at: at}
    {:reply, {:ok, alarm_id}, repo}
  end

  def handle_call({:delete_alarm, alarm_id}, _from, repo) do
    repo.get!(Model, alarm_id) |> repo.delete!
    {:reply, :ok, repo}
  end
end
