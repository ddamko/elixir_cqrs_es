defmodule Bank.AccountRepo do

  alias Bank.Account
  alias Bank.EventStore
  alias Bank.KeyPID

  def add_to_cache(id) do
    KeyPID.save(id, self)
  end

  def remove_from_cache(id) do
    KeyPID.delete(id)
  end

  def get_by_id(id) do
    case KeyPID.get(id) do
      :not_found -> load_from_eventstore(id)
      pid -> {:ok, pid}
    end
  end

  def load_from_eventstore(id) do
    case EventStore.get_events(id) do
      [] ->
        :not_found
      events ->
        pid = Account.new
        Account.load_from_history(pid, events)
        {:ok, pid}
    end
  end
end