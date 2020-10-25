class Option < ApplicationRecord
  validates :name, :number_of_sessions, presence: true
end