class RenameSessionsToPurchasedSessions < ActiveRecord::Migration[6.0]
  def change
    rename_table :sessions, :purchased_sessions
  end
end
