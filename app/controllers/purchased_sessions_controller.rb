class PurchasedSessionsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :redirect_if_user_has_not_completed_profile
  before_action :redirect_if_not_purchased_session_owner, only: [:show]

  def index
    @purchased_sessions = PurchasedSession.where(user_id: current_user.id)
  end

  def show
    @trainer = purchased_session.trainer
    @option = @purchased_session.option
    @sessions_remaining = @option.number_of_sessions - @purchased_session.sessions.count
  end

  private

  def redirect_if_not_purchased_session_owner
    unless purchased_session.user.id == current_user.id
      render_404
    end
  end

  def purchased_session
    @purchased_session ||= PurchasedSession.find(params[:id])
  end
end
