defmodule Bank.Connections.ReadStore do
  require Rethink

  def start_link() do
    Rethink.Connection.start_link(hostname: "localhost", port: 28017, database: "readstore")
  end
end