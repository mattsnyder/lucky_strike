defmodule BowlingAlley.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(BowlingAlley.Lane, [BowlingAlley.Lane]),
      supervisor(BowlingAlley.Bowler.Supervisor, [])
    ]

    supervise(children, strategy: :rest_for_one)
  end

end
