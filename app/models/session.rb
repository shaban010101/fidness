class Session < ApplicationRecord
  belongs_to :purchased_session
  belongs_to :availability

  validates :purchased_session_id, presence: true
  validate :session_date_not_in_past
  validate :validate_enough_sessions_left
  before_destroy :cancelable?
  
  scope :future_sessions, -> (trainer_id) do
    joins(:purchased_session)
    .joins(:availability)
     .where(purchased_sessions: { trainer_id: trainer_id })
     .where("availabilities.available_at > ?", Time.current)
  end  

  def session_date_not_in_past
    unless availability.available_at > Time.current
      errors.add(:session, 'cannot be in the past')
    end
  end
  
  def validate_enough_sessions_left
    sessions_left = purchased_session.option.number_of_sessions - purchased_session.sessions.count
    errors.add(:all, 'purchased sessions have been used') unless sessions_left > 0
  end

  def cancelable?
    cut_off_time = availability.available_at - 12.hours
    cancelable = availability.available_at >= cut_off_time

    unless cancelable
      errors.add :base, "Cannot delete session as it's less than 12 hours away"
      throw(:abort)
    end
  end
end

