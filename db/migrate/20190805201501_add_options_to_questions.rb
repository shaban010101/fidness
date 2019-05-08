class AddOptionsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :options, :text, array: :true, default: []
  end
end
