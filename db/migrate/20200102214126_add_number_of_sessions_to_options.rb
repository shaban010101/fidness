class AddNumberOfSessionsToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :number_of_sessions, :integer
  end
end
