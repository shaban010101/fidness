class CreatUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string :username, null: false
      table.string :email, null: false
      table.string :first_name, null: false
      table.string :last_name, null: false
      table.timestamps
    end
  end
end
