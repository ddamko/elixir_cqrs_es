defmodule Bank.Events.MoneyDeposited do
  alias Bank.Events.MoneyDeposited
  
  defstruct [:id, :amount, :new_balance, :transaction_date]
  @type t :: %MoneyDeposited{}
end