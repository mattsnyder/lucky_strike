defmodule BowlingAlley do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(BowlingAlley.Supervisor, []),
      worker(BowlingAlley.Lanes.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: BowlingAlley.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
