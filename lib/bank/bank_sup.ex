defmodule Bank.Suppervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  def start_bucket(supervisor) do
    Supervisor.start_child(supervisor, [])
  end

  def init(:ok) do
    children = [
      worker(Bank.EventBus, [], restart: :temporary),
      worker(Bank.AccountDetail, [], restart: :temporary),
      worker(Bank.AccountSummary, [], restart: :temporary)
    ]

    supervise(children, strategy: :one_for_one)
  end
end