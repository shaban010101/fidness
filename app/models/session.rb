class Session < ApplicationRecord
  belongs_to :purchased_session

  validates :purchased_session_id, :session_at, presence: true
  validate :session_date_not_in_past
  validate :validate_enough_sessions_left
  
  scope :future_sessions, -> (trainer_id) do
    joins(:purchased_session)
     .where(purchased_sessions: { trainer_id: trainer_id })
     .where("session_at > ?", Time.current)
  end  

  def session_date_not_in_past
    errors.add(:session, 'cannot be in the past') unless session_at > Time.current
  end
  
  def validate_enough_sessions_left
    sessions_left = purchased_session.option.number_of_sessions - purchased_session.sessions.count
    errors.add(:all, 'purchased sessions have been used') unless sessions_left > 0
  end
end

