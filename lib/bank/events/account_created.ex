defmodule Bank.Events.AccountCreated do
  alias Bank.Events.AccountCreated
  
  defstruct [:id, :date_created]
  @type t :: %AccountCreated{}
end