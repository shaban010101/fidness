class AddUserTypeToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_type, :string
  end
end
