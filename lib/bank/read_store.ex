defmodule Bank.ReadStore do

  ## Projections
  alias Bank.Projections.AccountSummary

  def init() do
    :ets.new(:read_store_summary_views, [:public, :named_table])
    set_bank_account_summary([%AccountSummary{}])
    set_bank_account_details([])
  end

  def get_bank_account_summary() do
    [{:bank_account_summary, summary}] = :ets.lookup(:read_store_summary_views, :bank_account_summary)
    summary
  end

  def set_bank_account_summary(new_data) do
    :ets.insert(:read_store_summary_views, {:bank_account_summary, new_data})
  end
  
  def get_bank_account_details() do
    [{:bank_account_details, details}] = :ets.lookup(:read_store_summary_views, :bank_account_details)
    details
  end
  
  def set_bank_account_details(new_data) do
    :ets.insert(:read_store_summary_views, {:bank_account_details, new_data})
  end
  
end