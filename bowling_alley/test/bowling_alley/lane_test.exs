defmodule BowlingAlley.LaneTest do
  use ExUnit.Case, async: true

  alias BowlingAlley.Lane, as: Lane
  alias BowlingAlley.Bowler, as: Bowler

  setup context do
    {:ok, lane} = Lane.start_link(context.test)
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


  # test "removes bowler on crash", %{lane: lane} do
  #   Lane.add(lane, "Matt")
  #   {:ok, bowler} = Lane.get(lane, "Matt")

  #   # Stop the bucket with non-normal reason
  #   Process.exit(bowler, :shutdown)

  #   # Wait until the bucket is dead
  #   ref = Process.monitor(bowler)
  #   assert_receive {:DOWN, ^ref, _, _, _}

  #   assert Lane.get(lane, "Matt") == :error
  # end
end
