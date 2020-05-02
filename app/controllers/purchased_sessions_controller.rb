class PurchasedSessionsController < ApplicationController
  def show
    @purchased_session = PurchasedSession.find(params[:id])
    @trainer = @purchased_session.trainer
    @option = @purchased_session.option
    @sessions_remaining = @option.number_of_sessions - @purchased_session.sessions.count
  end
end
