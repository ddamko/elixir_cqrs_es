defmodule Bank.Projections.AccountSummary do
  alias Bank.Projections.AccountSummary

  defstruct [:count_of_accounts]
  @type t :: %AccountSummary{}
 
  def init(accounts) do
    %AccountSummary{count_of_accounts: accounts}
  end
end