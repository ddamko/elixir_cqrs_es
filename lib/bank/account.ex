defmodule Bank.Account do
  require Record
  require Bank.Data

  Record.defrecord :state, [id: 0, date_created: nil, balance: 0, changes: []]

  @timeout 45000

  def new() do
    spawn fn -> init() end
  end

  ## API

  def create(pid, id) do
    send pid, {:attempt_command, {:create, id}}
  end

  def deposit(pid, amount) do
    send pid, {:attempt_command, {:deposit_money, amount}}
  end

  def withdraw_money(pid, amount) do
    send pid, {:attempt_command, {:withdraw_money, amount}}
  end

  def process_unsaved_changes(pid, saver) do
    send pid, {:process_unsaved_changes, saver}
  end

  def load_from_history(pid, events) do
    send pid, {:load_from_history, events}
  end

  def init() do
    state = state()
    loop(state)
  end

  def loop(state(id: id), state) do
  
  end

end