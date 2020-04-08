class AddUnavailablePeriod < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.timestamp :available_at, null: false
      t.references :user, index: true
    end
  end
end
