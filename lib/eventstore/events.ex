defmodule EventStore.Events do
  require Record

  Record.defrecord :bank_account_summary, [count_of_accounts: 0]
  @type bank_account_summary :: record(:bank_account_summary, count_of_accounts: integer)

  Record.defrecord :create_bank_account, [id: 0]
  @type create_bank_account :: record(:create_bank_account, id: integer)
end