defmodule BowlingAlley.Lanes.Lane do
  use GenServer

  ## Client API
  @doc """
  Opens a new lane.
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
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
  def get(lane, bowler_name)  do
    GenServer.call(lane, {:get, bowler_name})
  end

  @doc """
  Launch a new bowler agent.
  """
  def add(lane, bowler_name) do
    GenServer.cast(lane, {:add, bowler_name})
  end

  ## Server Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:get, bowler_name}, _from, bowlers) do
    {:reply, Map.fetch(bowlers, bowler_name), bowlers}
  end

  def handle_cast({:add, bowler_name}, bowlers) do
    if Map.has_key?(bowlers, bowler_name) do
      {:noreply, bowlers}
    else
      {:ok, bowler} = BowlingAlley.Lanes.Bowler.start_link
      {:noreply, Map.put(bowlers, bowler_name, bowler)}
    end
  end
end
