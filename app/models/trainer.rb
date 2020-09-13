class Trainer < User
  has_many :availabilities, foreign_key: :user_id
  has_many :purchased_sessions
  has_many :sessions, through: :purchased_sessions
end
