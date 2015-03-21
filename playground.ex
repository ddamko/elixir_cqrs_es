defmodule BankPlayground do

  defmodule State do
    defstruct [:id, :date_created, :balance, :changes]
    @type t :: %State{}
  end

  defmodule AccountCreated do
    defstruct [:id, :date_created]
    @type t :: %AccountCreated{}
  end

  defmodule MoneyDeposited do
    defstruct [:id, :amount, :new_balance, :transaction_date]
    @type t :: %MoneyDeposited{}
  end

  defmodule MoneyWithdrawn do
    defstruct [:id, :amount, :new_balance, :transaction_date]
    @type t :: %MoneyWithdrawn{}
  end

  defmodule PaymentDeclined do
    defstruct [:id, :amount, :transaction_date]
    @type t :: %PaymentDeclined{}
  end

  alias BankPlayground.State
  alias BankPlayground.AccountCreated
  alias BankPlayground.MoneyDeposited
  alias BankPlayground.MoneyWithdrawn
  alias BankPlayground.PaymentDeclined

  def new() do
    spawn fn -> init() end
  end

  def create(pid, id) do
    send pid, {:attempt_command, {:create, id}}
  end

  def deposit(pid, amount) do
    send pid, {:attempt_command, {:deposit_money, amount}}
  end

  def withdraw(pid, amount) do
    send pid, {:attempt_command, {:withdraw_money, amount}}
  end

  def init() do
    state = %{%State{} | :balance => 0} 
    loop(state)
  end

  def loop(state) do
    receive do
      {:apply_event, event} ->
        new_state = apply_event(event, state)
        loop(new_state)

      {:attempt_command, command} ->
        new_state = attempt_command(command, state)
        IO.inspect(new_state)
        loop(new_state)
    end
  end

  def attempt_command({:create, id}, state) do
    event = %{%AccountCreated{} | :id => id, :date_created => :calendar.local_time}
    apply_new_event(event, state)
  end

  def attempt_command({:deposit_money, amount}, state) do
    new_balance = Map.update(state, :balance, 0, &(&1 + amount))
    id = Map.get(state, :id)
    event = %{%MoneyDeposited{} | :id => id, :amount => amount, :new_balance => new_balance.balance, :transaction_date => :calendar.local_time}
    apply_new_event(event, state)
  end

  def attempt_command({:withdraw_money, amount}, state) do
    new_balance = Map.update(state, :balance, 0, &(&1 - amount))
    id = Map.get(state, :id)
    event = case Map.get(new_balance, :balance) < 0 do
      false ->
        %{%MoneyWithdrawn{} | :id => id, :amount => amount, :new_balance => new_balance.balance, :transaction_date => :calendar.local_time}
      true ->
        %{%PaymentDeclined{} | :id => id, :amount => amount, :transaction_date => :calendar.local_time}
    end
    apply_new_event(event, state)
  end

  def apply_new_event(event, state) do
    new_state = apply_event(event, state)
    Map.update(new_state, :changes, [], &[event|&1])
  end

  def apply_event(event = %BankPlayground.AccountCreated{}, state) do
    id = Map.get(event, :id)
    date = Map.get(event, :date_created)
    %{state | :id => id, :date_created => date}
  end

  def apply_event(event = %BankPlayground.MoneyDeposited{}, state) do
    amount = Map.get(event, :amount)
    balance = Map.get(state, :balance)
    new_balance = balance + amount
    %{state | :balance => new_balance}
  end

  def apply_event(event = %BankPlayground.MoneyWithdrawn{}, state) do
    amount = Map.get(event, :amount)
    balance = Map.get(state, :balance)    
    new_balance = balance - amount
    %{state | :balance => new_balance}
  end

  def apply_event(event = %BankPlayground.PaymentDeclined{}, state) do
    IO.puts "Sorry you do not have enough money."
    IO.inspect(event)
    state
  end
end