defmodule BowlingAlley.Supervisor do
  use Supervisor

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(BowlingAlley.Lanes.Lane, [BowlingAlley.Lanes.Lane]),
      supervisor(BowlingAlley.Bowler.Supervisor, [])
    ]

    supervise(children, strategy: :rest_for_one)
  end

end
