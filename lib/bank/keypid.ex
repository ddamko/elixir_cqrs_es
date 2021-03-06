defmodule Bank.KeyPID do
  @table_id __MODULE__

  def init() do
    :ets.new(@table_id, [:public, :named_table])
  end

  def delete(key) do
    :ets.delete(@table_id, key)
  end

  def save(key, pid) do
    save_helper(key, pid, is_pid(pid))
  end

  def save_helper(key, pid, true) do
    :ets.insert(@table_id, {key, pid})
  end

  def save_helper(_args) do
    false
  end

  def get(key) do
    case :ets.lookup(@table_id, key) do
      [{key, pid}] ->
        case is_pid(pid) and Process.alive?(pid) do
          true ->
            pid
          false ->
            :not_found
        end
      
      [] ->
        :not_found
    end
  end
end