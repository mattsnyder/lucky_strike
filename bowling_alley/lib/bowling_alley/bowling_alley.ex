defmodule BowlingAlley do
  use Application

  def start(_type, _args) do
    BowlingAlley.Supervisor.start_link
  end
end
