defmodule Bank.EventStore do
  require Exts
  @table_id __MODULE__

  def init() do
    Exts.new(@table_id, [:public, :named_table])
  end

  def append_events(key, events) do
    stored_events   = get_raw_events(key)
    new_events      = :lists.reverse(events)
    combined_events = new_events <> stored_events

    Exts.insert(@table_id, {key, combined_events})
    :lists.foreach(fn (event) -> Bank.EventBus.publish_event(event) end, new_events)
  end

  def get_events(key) do
    :lists.reverse(get_raw_events(key))
  end

  def delete(key) do
    Exts.delete(@table_id, key)
  end

  def get_raw_events(key) do
    case Exts.read(@table_id, key) do
      {key, events} -> events
      {} -> {}
    end
  end
  
end