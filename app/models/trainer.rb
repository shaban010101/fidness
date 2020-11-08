class Trainer < User
  has_many :availabilities, foreign_key: :user_id
  has_many :purchased_sessions
  has_many :sessions, through: :purchased_sessions

  scope :active, -> do
    joins(:profile)
      .where.not(first_name: nil)
      .where.not(last_name: nil)
      .where(profiles: { approved: true })
  end
end
