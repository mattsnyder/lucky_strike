defmodule BowlingAlley.Lane do
  use GenServer

  ## Client API
  @doc """
  Opens a new lane.
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  @doc """
  Closes the lane.
  """
  def stop(server) do
    GenServer.stop(server)
  end

  @doc """
  Lookup the named bowler agent.
  """
  def get(lane, bowler_name) when is_atom(lane)  do
    case :ets.lookup(lane, bowler_name) do
      [{^bowler_name, pid}] -> {:ok, pid}
      [] -> :error
    end
  end

  @doc """
  Launch a new bowler agent.
  """
  def add(lane, bowler_name) do
    GenServer.cast(lane, {:add, bowler_name})
  end

  ## Server Callbacks
  def init(table) do
    bowlers = :ets.new(table, [:named_table])
    refs  = %{}
    {:ok, {bowlers, refs}}
  end

  def handle_cast({:add, bowler_name}, {bowlers, refs}) do
   case get(bowlers, bowler_name) do
     {:ok, _pid} ->
	{:noreply, {bowlers, refs}}
     :error ->
	{:ok, pid} = BowlingAlley.Bowler.Supervisor.start_bowler
	ref = Process.monitor(pid)
	refs = Map.put(refs, ref, bowler_name)
	:ets.insert(bowlers, {bowler_name, pid})
	{:noreply, {bowlers, refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {bowler_name, refs} = Map.pop(refs, ref)
    :ets.delete(names, bowler_name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
