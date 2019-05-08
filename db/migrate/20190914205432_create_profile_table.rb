class CreateProfileTable < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :short_description
      t.string :long_description
      t.string :qualifications
      t.references :user
    end
  end
end
