defmodule Matryoshka.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Matryoshka.Server, [], [port: 9000]),
    ]

    opts = [strategy: :one_for_one, name: Matryoshka.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
