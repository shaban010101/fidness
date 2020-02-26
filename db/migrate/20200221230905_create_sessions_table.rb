class CreateSessionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |table|
      table.references :user, null: false
      table.references :trainer, null: false
      table.references :option, null: false
      table.timestamps
    end
  end
end
