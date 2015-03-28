defmodule Bank.Connections.EventStore do
  require Rethink

  def start_link() do
    Rethink.Connection.start_link(hostname: "localhost", port: 28015, database: "eventstore")
  end
end