defmodule Bank.Events.PaymentDeclined do
  alias Bank.Events.PaymentDeclined
  
  defstruct [:id, :amount, :transaction_date]
  @type t :: %PaymentDeclined{}
end