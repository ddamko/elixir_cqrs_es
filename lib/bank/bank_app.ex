defmodule BankApp do
  use Application

  def start(_type, _args) do
    Bank.EventStore.init()
    Bank.ReadStore.init()
    Bank.KeyPID.init()

    case Bank.Supervisor.start_link() do
      {:ok, pid} ->
        Bank.EventHandler.add_handler()
        Bank.CommandHandler.add_handler()
        {:ok, pid}

      error -> {:error, error}
    end
  end

  def stop(_state) do
    :ok
  end
end