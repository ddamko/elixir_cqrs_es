defmodule Bank.Commands.DepositMoney do
  alias Bank.Commands.DepositMoney
  
  defstruct [:id, :amount]
  @type t :: %DepositMoney{}
end