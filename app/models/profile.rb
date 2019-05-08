class Profile < ApplicationRecord
  belongs_to :user
  
  validates :short_description, presence: true, length: { minimum: 25, maximum: 50 }
  validates :long_description, presence: true, length: { minimum: 120, maximum: 240 }
  validates :qualifications, presence: true
  validates :price, presence: true, unless: Proc.new { user.type == 'Client' }
end
