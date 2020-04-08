class AddIndexToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    add_index :availabilities, [:user_id, :available_at], unique: true
  end
end
