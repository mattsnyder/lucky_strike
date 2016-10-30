defmodule BowlingAlley.LaneTest do
  use ExUnit.Case, async: true

  alias BowlingAlley.Lane, as: Lane
  alias BowlingAlley.Bowler, as: Bowler

  setup context do
    {:ok, _} = Lane.start_link(context.test)
    {:ok, lane: context.test}
  end

  test "spawns a bowler", %{lane: lane} do
    assert Lane.get(lane, "Matt") == :error

    Lane.add(lane, "Matt")
    assert {:ok, bowler} = Lane.get(lane, "Matt")

    Bowler.roll(bowler, 7)
    assert Bowler.rolls(bowler) == [7]
  end

  test "removes bowler on exit", %{lane: lane} do
    BowlingAlley.Lane.add(lane, "Joe")
    {:ok, bucket} = BowlingAlley.Lane.get(lane, "Joe")
    Agent.stop(bucket)

    # Do a call to ensure the lane processed the DOWN message
    _ = BowlingAlley.Lane.add(lane, "bogus")
    assert BowlingAlley.Lane.get(lane, "Joe") == :error
  end

  test "removes bowler on crash", %{lane: lane} do
    BowlingAlley.Lane.add(lane, "Joe")
    {:ok, bucket} = BowlingAlley.Lane.get(lane, "Joe")

    # Kill the bucket and wait for the notification
    Process.exit(bucket, :shutdown)

    # Wait until the bucket is dead
    ref = Process.monitor(bucket)
    assert_receive {:DOWN, ^ref, _, _, _}

    # Do a call to ensure the lane processed the DOWN message
    _ = BowlingAlley.Lane.add(lane, "Matt")
    assert BowlingAlley.Lane.get(lane, "Joe") == :error
  end
end
