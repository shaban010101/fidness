class PaymentIntentsController < ApplicationController
  include SessionHelper

  def intent
    params.permit(:option_id, :trainer_id, :session_at)
    trainer = Trainer.find(params[:trainer_id])
    number_of_sessions = Option.find(params[:option_id]).number_of_sessions
    
    amount = sessions_cost(trainer, number_of_sessions, discount_percentage: session_discount[number_of_sessions.to_s])

    intent = Stripe::PaymentIntent.create({
                                   amount: (amount * 100).to_i,
                                   currency: 'gbp',
                                   metadata: { 
                                     trainer_id: params[:trainer_id],
                                     option_id: params[:option_id],
                                     session_at: params[:session_at],
                                     user_id: current_user.id
                                 }})

    render json: { client_secret: intent.client_secret }, status: 200
  end
  
  private
  
  def sessions_params
    params.permit(:option, :address_line_1, :city, :post_code, :card_number, :cvv_code,:expiry_month_year, :trainer_id)
  end
end
