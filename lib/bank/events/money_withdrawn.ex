defmodule Bank.Events.MoneyWithdrawn do
  alias Bank.Events.MoneyWithdrawn
  
  defstruct [:id, :amount, :new_balance, :transaction_date]
  @type t :: %MoneyWithdrawn{}
end