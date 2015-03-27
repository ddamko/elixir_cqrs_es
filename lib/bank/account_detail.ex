defmodule Bank.AccountDetail do
  use GenServer
  require Logger
  
  @server __MODULE__

  ## Events
  alias Bank.Events.AccountCreated
  alias Bank.Events.MoneyDeposited
  alias Bank.Events.MoneyWithdrawn
  alias Bank.Events.PaymentDeclined

  ## Read Storage
  alias Bank.ReadStore

  def start_link() do
    GenServer.start_link(@server, :ok, [])
  end
  
  def process_event(event) do
    {:ok, pid} = @server.start_link
    #IO.inspect(event)
    GenServer.cast(pid, {:event, event})
  end

  def init(:ok) do
    list = ReadStore.get_bank_account_details()
    details = :dict.from_list(list)
    {:ok, details}
  end

  def handle_call(_request, _from, state) do
    {:reply, :ok, state}
  end
  
  def handle_cast({:event, event = %AccountCreated{}}, details) do
    new_details = :dict.store(event.id, 0, details)
    IO.puts "Account Created"
    update_read_store(new_details)
    {:noreply, new_details}
  end

  def handle_cast({:event, event = %MoneyWithdrawn{}}, details) do
    new_details = :dict.store(event.id, event.new_balance, details)
    IO.puts "Money Withdrawn"
    update_read_store(new_details)
    {:noreply, new_details}
  end

  def handle_cast({:event, event = %PaymentDeclined{}}, details) do
    :error_logger.info_msg("Payment declined for Account: ~p. Shame, shame!~n", [event.id])
    {:noreply, details}
  end

  def handle_cast({:event, event = %MoneyDeposited{}}, details) do
    new_details = :dict.store(event.id, event.new_balance, details)
    IO.puts "Money Deposited"
    IO.puts "New State with Changes:"
    update_read_store(new_details)
    {:noreply, new_details}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def update_read_store(details) do
    ReadStore.set_bank_account_details(:dict.to_list(details))
  end

  def handle_info(_info, state) do
    {:noreply, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  def code_change(_old_vsn, state, _extra) do
    {:ok, state}
  end

end