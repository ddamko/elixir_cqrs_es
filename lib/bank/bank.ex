defmodule Bank do
  require Bank.Data

  def open do
    BankApp.start()
  end

  def close() do
    BankApp.stop()
  end

  def create(account) do
    Bank.EventBus.send_command(Bank.Data.create_account(id: account))
  end

  def deposit(account, amount) do
    Bank.EventBus.send_command(Bank.Data.deposit_money(id: account, amount: amount))
  end

  def withdraw(account, amount) do
    Bank.EventBus.send_command(Bank.Data.withdraw_money(id: account, amount: amount))
  end

  def balance(account) do
    details = Bank.ReadStore.get_account_details()
    dict = details |> Enum.into(HashDict.new)
    case dict.fetch(dict, account) do
      {:ok, value} -> value
      _ -> :no_account
    end
  end
end

