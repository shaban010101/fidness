class Availability < ApplicationRecord
  validates :available_at, :user_id, presence: true
  validates :available_at, uniqueness: { scope: :user_id }
end
