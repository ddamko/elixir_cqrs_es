defmodule Bank.Data do
  require Record

  # Projections
  Record.defrecord :account_summary,  [count_of_accounts: 0]
  
  # Commands
  Record.defrecord :create_account,   [id: nil]
  Record.defrecord :deposit_money,    [id: nil, amount: 0]
  Record.defrecord :withdraw_money,   [id: nil, amount: 0]

  # Events
  Record.defrecord :account_created,  [id: nil, date_created: nil]
  Record.defrecord :money_deposited,  [id: nil, amount: 0, new_balance: 0, transaction_date: nil]
  Record.defrecord :money_withdrawn,  [id: nil, amount: 0, new_balance: 0, transaction_date: nil]
  Record.defrecord :payment_declined, [id: nil, amount: 0, transaction_date: nil]
end