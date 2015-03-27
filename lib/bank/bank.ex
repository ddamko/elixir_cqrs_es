defmodule Bank do
  ## Commands
  alias Bank.Commands.CreateAccount
  alias Bank.Commands.DepositMoney
  alias Bank.Commands.WithdrawMoney

  ## Event Bus
  alias Bank.EventBus

  ## Readstore
  alias Bank.ReadStore

  def open do
    BankApp.start(:type, :args)
  end

  def close() do
    BankApp.stop(:stop)
  end

  def create(account) do
    EventBus.send_command(%{%CreateAccount{} | :id => account})
  end

  def deposit(account, amount) do
    EventBus.send_command(%{%DepositMoney{} | :id => account, :amount => amount})
  end

  def withdraw(account, amount) do
    EventBus.send_command(%{%WithdrawMoney{} | :id => account, :amount => amount})
  end

  def check_balance(account) do
    details = ReadStore.get_bank_account_details()
    dict = details |> Enum.into(HashDict.new)

    case HashDict.fetch(dict, account) do
      {:ok, value} -> value
      _ -> :no_account
    end
  end
end

