defmodule Bank.CommandHandler do
  use GenEvent
  require Logger

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
  
  def handle_event(command = %CreateAccount{}, state) do
    IO.puts "Command Handler: Create Account"
    case AccountRepo.get_by_id(command.id) do
      :not_found ->
        pid = Account.new
        Account.create(pid, command.id)
        AccountRepo.save(pid)
        {:ok, state}
      
      [] ->
        {:ok, state}
    end
  end
  
  def handle_event(command = %DepositMoney{}, state) do
    IO.puts "Command Handler: Deposit Money"
    case AccountRepo.get_by_id(command.id) do
      :not_found ->
        Logger.error("No account found for: ~p~n",[command.id])
        {:ok, state}

      {:ok, pid} ->
        Account.deposit(pid, command.amount)
        AccountRepo.save(pid)
        {:ok, state}
    end
  end

  def handle_event(command = %WithdrawMoney{}, state) do
    IO.puts "Command Handler: Withdraw Money"
    case AccountRepo.get_by_id(command.id) do
      :not_found ->
        Logger.error("No account found for: ~p~n",[command.id])
        {:ok, state}

      {:ok, pid} ->
        Account.withdraw(pid, command.amount)
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