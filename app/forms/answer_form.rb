class AnswerForm
  attr_accessor :answer, :question_id, :user_id
  include ActiveModel::Model
  
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :answer, presence: true
end
