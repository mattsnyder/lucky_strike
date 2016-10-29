defmodule BowlingAlley.Lanes.BowlerTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bowler} = BowlingAlley.Lanes.Bowler.start_link
    {:ok, bowler: bowler}
  end

  test "record rolls", %{bowler: bowler} do
    assert BowlingAlley.Lanes.Bowler.rolls(bowler) == []

    BowlingAlley.Lanes.Bowler.roll(bowler, 3)
    assert BowlingAlley.Lanes.Bowler.rolls(bowler) == [3]
  end
end
