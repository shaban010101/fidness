class PurchasedSession < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :trainer
  has_many :sessions
  has_many :availabilities, through: :sessions
  
  validates :option_id, :user_id, :trainer_id, presence: true

  scope :future_sessions, -> (user_id) do
    Time.zone = User.find(user_id).try(:time_zone) || 'UTC'
    joins(:availabilities)
        .joins(:sessions)
        .where("availabilities.available_at >= ?", "#{Time.current}")
        .where(user_id: user_id)
  end
end
