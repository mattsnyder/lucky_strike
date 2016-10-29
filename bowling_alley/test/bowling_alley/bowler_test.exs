defmodule BowlingAlley.BowlerTest do
  use ExUnit.Case, async: true
  alias BowlingAlley.Bowler, as: Bowler

  setup do
    {:ok, bowler} = Bowler.start_link
    {:ok, bowler: bowler}
  end

  test "record rolls", %{bowler: bowler} do
    assert Bowler.rolls(bowler) == []

    Bowler.roll(bowler, 3)
    assert Bowler.rolls(bowler) == [3]
  end
end
