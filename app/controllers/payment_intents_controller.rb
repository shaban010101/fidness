class PaymentIntentsController < ApplicationController
  include SessionHelper

  def intent
    params.permit(:option_id, :trainer_id, :session_at, :authenticity_token)
    trainer = Trainer.find(params[:trainer_id])
    option = Option.find(params[:option_id])
    binding.pry
    amount = sessions_cost(trainer, option, discount_percentage: session_discount[option.number_of_sessions.to_s])

    intent = Stripe::PaymentIntent.create({
                                   amount: amount.to_i,
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
end
