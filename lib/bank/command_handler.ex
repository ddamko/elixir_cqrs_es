defmodule Bank.CommandHandler do
  use GenEvent

  ## Commands
  alias Bank.Commands.CreateAccount
  alias Bank.Commands.DepositMoney
  alias Bank.Commands.WithdrawMoney

  ## Event Bus
  alias Bank.EventBus

  ## Acccount Repo
  alias Bank.AccountRepo

  ## Bank Account
  alias Bank.Account

  def add_handler() do
    EventBus.add_handler(__MODULE__, [])
  end

  def delete_handler() do
    EventBus.add_handler(__MODULE__, [])
  end

  def init([]) do
    {:ok, []}
  end
  
  def handle_event(event = %CreateAccount{}, state) do
    case AccountRepo.get_by_id(event.id) do
      :not_found ->
        pid = Account.new
        Account.create(pid, event.id)
        AccountRepo.save(pid)
        {:ok, state}
      
      [] ->
        {:ok, state}
        
      _ ->
        {:ok, state}
    end
  end
  
  def handle_event(event = %DepositMoney{}, state) do
    case AccountRepo.get_by_id(event.id) do
      :not_found ->
        {:ok, state}

      {:ok, pid} ->
        Account.deposit(pid, event.amount)
        AccountRepo.save(pid)
        {:ok, state}
    end
  end

  def handle_event(event = %WithdrawMoney{}, state) do
    case AccountRepo.get_by_id(event.id) do
      :not_found ->
        {:ok, state}

      {:ok, pid} ->
        Account.withdraw(pid, event.amount)
        AccountRepo.save(pid)
        {:ok, state}
    end
  end
  
  def handle_event(_, state) do
    {:ok, state}
  end

  def handle_call(_, state) do
    {:ok, state}
  end
  
  def handle_info(_, state) do
    {:ok, state}
  end
  
  def terminate(_reason, _state) do
    :ok
  end
  
  def code_change(_old_vsn, state, _extra) do
    {:ok, state}
  end
  

end