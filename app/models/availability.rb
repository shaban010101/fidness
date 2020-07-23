class Availability < ApplicationRecord
  belongs_to :user
  has_one :session

  validates :available_at, :user_id, presence: true
  validates :available_at, uniqueness: { scope: :user_id }
  validate :available_at_not_in_the_past

  def available_at_not_in_the_past
    errors.add(:available_at, 'Availability should be in the future') if available_at.past?
  end
end
