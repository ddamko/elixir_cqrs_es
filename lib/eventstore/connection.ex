defmodule EventStore.Connection do
  use GenServer

  def start_link() do
    start_link(hostname: "localhost", port: 28015, database: "test")
  end

  def start_link(options) do
    options = Enum.reject(options, fn {_k, v} -> is_nil(v) end)
    Rethink.Connection.start_link(options)
  end

  def init([]) do
    {:ok, %{database: nil, token: 1}}
  end

end