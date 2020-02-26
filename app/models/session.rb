class Session < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :trainer
  
  validates :option_id, :user_id, :trainer_id, presence: true
end
