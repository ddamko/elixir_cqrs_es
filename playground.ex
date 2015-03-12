defmodule Playground do
  require Record

  Record.defrecord :state, [id: 0, date_created: nil, balance: 0, changes: []]
  Record.defrecord :account_created, [id: nil, date_created: nil]
  
  def new() do
    spawn fn -> init() end
  end

  def create(pid, id) do
    send pid, {:attempt_command, {:create, id}}
  end

  def init() do
    state = state()
    loop(state)
  end

  def loop(state) do
    receive do
      {:attempt_command, command} ->
        new_state = attempt_command(command, state)
        loop(new_state)
    end
  end

  def attempt_command({:create, id}, state) do
    event = account_created(id: id, date_created: :calendar.local_time)
    apply_new_event(event, state)
    IO.inspect event
    IO.inspect state
  end

  def apply_new_event(event, state) do
    apply_event(event, state)
  end

  def apply_event(_event, state) do
    state
  end
    
end