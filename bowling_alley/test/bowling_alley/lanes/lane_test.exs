defmodule BowlingAlley.Lanes.LaneTest do
  use ExUnit.Case, async: true

  alias BowlingAlley.Lanes.Lane, as: Lane
  alias BowlingAlley.Lanes.Bowler, as: Bowler

  setup do
    {:ok, lane} = Lane.start_link
    {:ok, lane: lane}
  end

  test "spawns a bowler", %{lane: lane} do
    assert Lane.get(lane, "Matt") == :error

    Lane.add(lane, "Matt")
    assert {:ok, bowler} = Lane.get(lane, "Matt")

    Bowler.roll(bowler, 7)
    assert Bowler.rolls(bowler) == [7]
  end

  # test "removes bowler on exit", %{lane: lane} do
  #   Lane.add(lane, "Snyder")
  #   {:ok, bowler} = Lane.get(lane, "Snyder")
  #   Agent.stop(bowler)
  #   assert Lane.get(lane, "Snyder") == :error
  # end
end
