class FutureSessionsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :redirect_if_user_has_not_completed_profile
  before_action only: [:destroy] do
    redirect_if_user_cannot_access_session('future_sessions')
  end

  def index
    @sessions = PurchasedSession.future_sessions(current_user.id).flat_map &:sessions
  end

  def create
    session_at = Time.zone.parse(future_session_params[:session_at])
    purchased_session = PurchasedSession.find(future_session_params[:purchased_session_id])

    availability = Availability.where(
      available_at: session_at,
      user_id: future_session_params[:trainer_id]).last

    render(json: {errors: 'Trainer no longer available'}, status: 422) unless availability

    session = Session.new(
      purchased_session_id: purchased_session.id,
      availability_id: availability.id)

    if session.save
      render json: {id: session.id}, status: 200
    else
      render json: {errors: session.errors.full_messages}, status: 422
    end
  end

  def destroy
    if session.destroy
      flash[:success] = 'Future session removed'
      redirect_to future_sessions_path
    else
      flash[:error] = session.errors.first
      redirect_to future_sessions_path
    end
  end

  private

  def future_session_params
    params.permit(:purchased_session_id, :session_at, :trainer_id, :authenticity_token)
  end

  def _session
    @session ||= Session.find(params[:id])
  end
end


