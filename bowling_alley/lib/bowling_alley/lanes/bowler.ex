defmodule BowlingAlley.Lanes.Bowler do
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def rolls(bowler) do
    Agent.get(bowler, fn list -> list end)
  end

  def roll(bowler, roll) do
    Agent.update(bowler, fn list -> list ++ [roll] end)
  end
end
