defmodule Bank.EventHandler do
  use GenEvent

  ## Events
  alias Bank.Events.AccountCreated
  alias Bank.Events.MoneyDeposited
  alias Bank.Events.MoneyWithdrawn
  alias Bank.Events.PaymentDeclined

  ## Event Bus
  alias Bank.EventBus

  ## Projections
  alias Bank.AccountSummary
  alias Bank.AccountDetail

  def add_handler do
    EventBus.add_handler(__MODULE__, [])
  end

  def delete_handler do
    EventBus.delete_handler(__MODULE__, [])
  end

  def init([]) do
    {:ok, []}
  end

  def handle_event(event = %AccountCreated{}, state) do
    IO.puts "Event Handler: Account Created"
    AccountSummary.new_bank_account(event.id)
    AccountDetail.process_event(event)
    {:ok, state}
  end

  def handle_event(event = %MoneyDeposited{}, state) do
    IO.puts "Event Handler: Money Deposited"
    AccountDetail.process_event(event)
    {:ok, state}
  end

  def handle_event(event = %MoneyWithdrawn{}, state) do
    IO.puts "Event Handler: Money Withdrawn"
    AccountDetail.process_event(event)
    {:ok, state}
  end

  def handle_event(event = %PaymentDeclined{}, state) do
    IO.puts "Event Handler: Payment Declined"
    AccountDetail.process_event(event)
    {:ok, state}
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

  def code_chamge(_old_vsn, state, _extra) do
    {:ok, state}
  end
end