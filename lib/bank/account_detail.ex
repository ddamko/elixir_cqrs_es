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
    GenServer.cast({@server, __MODULE__}, event)
  end

  def init(:ok) do
    list = ReadStore.get_bank_account_details()
    details = :dict.from_list(list)
    {:ok, details}
  end

  def handle_call(_request, _from, state) do
    {:reply, :ok, state}
  end
  
  def handle_cast(event = %AccountCreated{}, details) do
    id = Map.get(event, :id)
    new_details = :dict.store(id, 0, details)
    update_read_store(new_details)
    {:noreply, new_details}
  end

  def handle_cast(event = %MoneyWithdrawn{}, details) do
    id = Map.get(event, :id)
    balance = Map.get(event, :balance)
    new_details = :dict.store(id, balance, details)
    update_read_store(new_details)
    {:noreply, new_details}
  end

  def handle_cast(event = %PaymentDeclined{}, details) do
    id = Map.get(event, :id)
    Logger.error("Payment declined for Account: ~p. Shame, shame!~n", [id])
    {:noreply, details}
  end

  def handle_cast(event = %MoneyDeposited{}, details) do
    id = Map.get(event, :id)
    balance = Map.get(event, :balance)
    new_details = :dict.store(id, balance, details)
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