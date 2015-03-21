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

  def handle_event(event = %AccountCreated{}) do
    id = Map.get(event, :id)
    AccountSummary.new_bank_account(id)
    AccountDetail.process_event(event)
  end

end