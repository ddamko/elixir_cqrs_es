defmodule Bank.Commands.CreateAccount do
  alias Bank.Commands.CreateAccount

  defstruct [:id]
  @type t :: %CreateAccount{}
end