defmodule Bank.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  def start_bucket(supervisor) do
    Supervisor.start_child(supervisor, [])
  end

  def init(:ok) do
    children = [
      worker(Bank.EventBus,                [], restart: :permanent),
      worker(Bank.AccountDetail,           [], restart: :permanent),
      worker(Bank.AccountSummary,          [], restart: :permanent)
    ]

    supervise(children, strategy: :one_for_one)
  end
end