defmodule Bank.Connections.Supervisor do
  use Supervisor
  require Rethink

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Rethink.Connection, [[hostname: "localhost", port: 28015, database: "eventstore"]], restart: :permanent),
      worker(Rethink.Connection, [[hostname: "localhost", port: 28017, database: "readstore"]], restart: :permanent)
    ]

    supervise(children, strategy: :one_for_one)
  end
end