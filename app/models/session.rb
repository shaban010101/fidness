class Session < ApplicationRecord
  belongs_to :purchased_session

  validates :purchased_session_id, :session_at, presence: true
  validate :session_date_not_in_past
  
  scope :future_sessions, -> (trainer_id) do
    joins(:purchased_session)
     .where(purchased_sessions: { trainer_id: trainer_id })
     .where("session_at > ?", Time.current)
  end  

  def session_date_not_in_past
    session_at > Time.current
  end  
end
