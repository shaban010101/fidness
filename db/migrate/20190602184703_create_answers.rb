class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false, references: [:questions, :id]
      t.integer :user_id, null: false, references: [:users, :id]
    end
  end
end
