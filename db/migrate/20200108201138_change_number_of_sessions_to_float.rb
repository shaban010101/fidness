class ChangeNumberOfSessionsToFloat < ActiveRecord::Migration[6.0]
  def change
    remove_column :options, :number_of_sessions
    add_column :options, :number_of_sessions, :decimal, precision: 2, scale: 2
  end
end
