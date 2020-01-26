class ChangeNumberOfSessionsToFloat < ActiveRecord::Migration[6.0]
  def change
    remove_column :options, :number_of_sessions, :integer
    add_column :options, :number_of_sessions, :decimal, precision: 8, scale: 2
  end
end
