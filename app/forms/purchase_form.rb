require 'date'
# Name as it appears on the card
class PurchaseForm
  include SessionHelper
  include ActiveModel::Model
  
  attr_accessor :option, :address_line_1, :city, :post_code, :card_number, :cvv, :expiry_month_year, :trainer_id, :current_user

  validates :option, :address_line_1, :city, :post_code, :card_number, :cvc_code,:expiry_month_year, :trainer_id, presence: true

  validates :card_number, length: { in: 12..19 }
  validates :cvv, length: { in: 3..4 }
  validate :valid_date?

  def initialize(current_user, params = {})
    super(params)
    @current_user = current_user
  end

  def save
    trainer = Trainer.find(trainer_id)
    number_of_sessions = Option.find(option).number_of_sessions
    amount = sessions_cost(trainer, number_of_sessions, discount_percentage: session_discount[number_of_sessions])
    
    Stripe::Charge.create({
                            amount: amount,
                            currency: 'gbp',
                            source: 'tok_mastercard',
                            description: 'Charge for jenny.rosen@example.com'
                          })
  end

  def valid_date?
    date = Date.strptime(expiry_month_year,"%Y-%m")
    if date.present? || date.future?
      true
    else
      errors.add(:invalid_date, 'Please provide a date which is not in the past')
      false
    end
  end
end
