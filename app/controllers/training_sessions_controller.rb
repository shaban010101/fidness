class TrainingSessionsController < ApplicationController
  include SessionHelper

  def create
    params.permit(:option_id, :trainer_id)
    session = PurchasedSession.create(option_id: params[:option_id], trainer_id: params[:trainer_id], user_id: current_user.id)
    if session
      render json: { id: session.id }
    else
      render json: { errors: session.errors.full_error_messages }, status: 422
    end
  end

  def show
    @session = Session.find(params[:id])
    @trainer = @session.trainer
    @option = @session.option
  end

  def intent
    params.permit(:option_id, :trainer_id)
    trainer = Trainer.find(params[:trainer_id])
    number_of_sessions = Option.find(params[:option_id]).number_of_sessions
    
    amount = sessions_cost(trainer, number_of_sessions, discount_percentage: session_discount[number_of_sessions.to_s])ss

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
