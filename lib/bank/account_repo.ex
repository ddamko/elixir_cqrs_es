defmodule Bank.AccountRepo do

  def add_to_cache(id) do
    Bank.KeyPID.save(id, self)
  end

  def remove_from_cache(id) do
    Bank.KeyPID.delete(id)
  end

  def get_by_id(id) do
    case Bank.KeyPID.get(id) do
      :not_found -> load_from_eventstore(id)
      pid -> {:ok, pid}
    end
  end

  def load_from_eventstore(id) do
    case Bank.EventStore.get_events(id) do
      [] ->
        :not_found
      events ->
        pid = Bank.Account.new
        Bank.Account.load_from_history(pid, events)
        {:ok, pid}
    end
  end
end