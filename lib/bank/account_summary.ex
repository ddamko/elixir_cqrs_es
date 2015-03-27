defmodule Bank.AccountSummary do
  use GenServer
  @server __MODULE__

  ## Read Storage
  alias Bank.ReadStore

  def start_link() do
    GenServer.start_link(@server, :ok, [])
  end

  def new_bank_account(id) do
    {:ok, pid} = @server.start_link
    GenServer.cast(pid, {:new_bank_account, id})
  end

  def init(:ok) do
    state = ReadStore.get_bank_account_summary()
    {:ok, state}
  end

  def handle_call(_request, _from, state) do
    {:reply, :ok, state}
  end

  def handle_cast({:new_bank_account, id}, state) do
    new_summary = Map.update(state, :count_of_accounts, 0, &(&1 + 1))
    ReadStore.set_bank_account_summary(new_summary)
    {:noreply, new_summary}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
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