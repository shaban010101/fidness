class AddTimestampsToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    change_table :availabilities do |t|
      t.timestamps
    end
  end
end
