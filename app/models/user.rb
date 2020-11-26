class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :answers, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one_attached :avatar

  validates :avatar, dimension: { width: { min: 120, max: 200 }, height: { min: 150, max: 200  } }
  validates :email, presence: true, uniqueness: true
  validates :sex, inclusion: %w(Male Female), allow_nil: true
  validates :type, presence: true, inclusion: %w(Trainer Client)
  validate :terms_and_conditions

  def trainer?
    type == 'Trainer'
  end

  def client?
    type == 'Client'
  end

  private

  def terms_and_conditions
    unless terms_and_conditions_accepted == true
      errors.add(:base, 'Terms and conditions must be accepted to sign up')
    end
  end
end
