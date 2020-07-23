class RemoveSessionAtFromSessions < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :session_at
    add_reference :sessions, :availability, null: false, foreign_key: true
  end
end
