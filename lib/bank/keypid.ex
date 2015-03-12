defmodule Bank.KeyPID do
  require Exts
  @table_id __MODULE__

  def init() do
    Exts.new(@table_id, [:public, :named_table])
  end

  def delete(key) do
    Exts.delete(@table_id, key)
  end

  def save(key, pid) do
    save_helper(key, pid, is_pid(pid))
  end

  def save_helper(key, pid, true) do
    Exts.insert(@table_id, {key, pid})
  end

  def save_helper(_args) do
    false
  end

  def get(key) do
    case Exts.read(@table_id, key) do
      {key, pid} ->
        case is_pid(pid) and Process.alive?(pid) do
          true ->
            pid
          false ->
            :not_found
        end
      {_} ->
        :not_found
    end
  end
end