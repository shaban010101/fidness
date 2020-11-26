class AddTermsAndConditionsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :terms_and_conditions_accepted, :boolean, default: false, null: false
  end
end
