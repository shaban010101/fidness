class CreateSessionTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.references :purchased_session, null: false
      t.timestamp  :session_at, null: false
      t.timestamps
    end
  end
end
