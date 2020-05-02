class PurchasedSession < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :trainer
  has_many :sessions
  
  validates :option_id, :user_id, :trainer_id, presence: true

  scope :future_sessions,  -> (user_id) do
    where(user_id: user_id).each do |purchased_session|
      purchased_session.sessions.where("session_at >= ?", "#{Time.current}")
    end  
  end  
end
