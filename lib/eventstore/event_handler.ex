defmodule EventStore.EventHandler do
  use GenEvent

  require EventStore.Events

  def handle_event({:event, x}, state) do

    Rethink.Connection.run()

    {:ok, [x|messages]}
  end

  def handle_call(:messages, messages) do
    {:ok, messages, []}
  end
end