defmodule Bank.Data do
  require Record

  # Projections
  Record.defrecord :account_summary, [count_of_accounts: 0]
  
  # Commands
  Record.defrecord :create_account,  [id: 0]
  Record.defrecord :deposit_money,   [id: 0, amount: 0]
  Record.defrecord :withdraw_money,  [id: 0, amount: 0]

end