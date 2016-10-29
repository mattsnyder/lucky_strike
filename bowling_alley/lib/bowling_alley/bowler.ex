defmodule BowlingAlley.Bowler do
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  Return all rolls recorded for this bowler.
  """
  def rolls(bowler) do
    Agent.get(bowler, fn list -> list end)
  end

  @doc """
  Record a new roll for this bowler.
  """
  def roll(bowler, roll) do
    Agent.update(bowler, fn list -> list ++ [roll] end)
  end
end
