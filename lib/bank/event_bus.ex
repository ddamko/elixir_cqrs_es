defmodule Bank.EventBus do
  @server __MODULE__

  def start_link() do
    GenEvent.start_link([{:name, @server}])
  end

  def add_handler(handler, args) do
    GenEvent.add_handler(@server, handler, args)
  end

  def delete_handler(handler, args) do
    GenEvent.delete_handler(@server, handler, args)
  end

  def send_command(command) do
    GenEvent.notify(@server, command)
  end

  def publish_event(event) do
    GenEvent.notify(@server, event)
  end
end