defmodule BowlingAlley.Bowler.Supervisor do
  use Supervisor

   @name BowlingAlley.Bowler.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_bowler do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    children = [
      worker(BowlingAlley.Bowler, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
