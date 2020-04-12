class FutureSessionsController < ApplicationController
  def index

  end

  def create
    params.permit(:option_id, :trainer_id, :session_at)
    purchased_session = PurchasedSession.new(option_id: params[:option_id], trainer_id: params[:trainer_id], user_id: current_user.id)
    
    begin 
      ActiveRecord::Base.transaction do
        purchased_session.save
        binding.pry
        Session.create(purchased_session_id: purchased_session.id, session_at: params[:session_at])
      end
      render json: { id: purchased_session.id }, status: 200
    rescue ActiveRecord::Rollback => e
      render json: { errors: 'Session could not be saved' }, status: 422
    end
  end
end
