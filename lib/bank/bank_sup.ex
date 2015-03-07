defmodule Bank.Suppervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Bank.EventBus, []),
      worker(Bank.AccountDetail, []),
      worker(Bank.AccountSummary, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end