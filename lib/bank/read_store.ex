defmodule Bank.ReadStore do
  require Exts

  ## Projections
  alias Bank.Projections.AccountSummary

  def init() do
    Exts.new(:read_store_summary_views, [:public, :named_table])
    set_bank_account_summary(%AccountSummary{})
    set_bank_account_details([])
  end

  def get_bank_account_summary() do
    [{bank_account_summary, summary}] = Exts.read(:read_store_summary_views, :bank_account_summary)
    summary
  end

  def set_bank_account_summary(new_data) do
    Exts.write(:read_store_summary_views, {:bank_account_summary, new_data})
  end
  
  def get_bank_account_details() do
    [{bank_account_details, details}] = Exts.read(:read_store_summary_views, :bank_account_details)
    details
  end
  
  def set_bank_account_details(new_data) do
    Exts.write(:read_store_summary_views, {:bank_account_details, new_data})
  end
  
end