class PurchasedSession < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :trainer
  has_many :sessions
  
  validates :option_id, :user_id, :trainer_id, presence: true
end
