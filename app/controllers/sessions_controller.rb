class SessionsController < ApplicationController
  include SessionHelper

  def new
    @trainer = Trainer.find(params[:trainer_id])
  end

  def create
    purchase_form = PurchaseForm.new(current_user, sessions_params)
    if purchase_form.save
      render json: { success: true }, status: 201 
    else
      render json: { errors: purchase_form.errors.full_messages }, status: 422
    end
  end

  def show
  end

  def intent
    params.permit(:option_id, :trainer_id)
    trainer = Trainer.find(params[:trainer_id])
    number_of_sessions = Option.find(params[:option_id]).number_of_sessions
    
    amount = sessions_cost(trainer, number_of_sessions, discount_percentage: session_discount[number_of_sessions.to_s])

    intent = Stripe::PaymentIntent.create({
                                   amount: (amount * 100).to_i,
                                   currency: 'gbp'
                                 })

    render json: { client_secret: intent.client_secret }, status: 200
  end
  
  private
  
  def sessions_params
    params.permit(:option, :address_line_1, :city, :post_code, :card_number, :cvv_code,:expiry_month_year, :trainer_id)
  end
end
