defmodule Bank.Commands.WithdrawMoney do
  alias Bank.Commands.WithdrawMoney
  
  defstruct [:id, :amount]
  @type t :: %WithdrawMoney{}
end