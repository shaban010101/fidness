class PurchasedSessionsController < ApplicationController
  def show
    @purchased_sessions = PurchasedSession.find(params[:id])
    @trainer = @purchased_sessions.trainer
    @option = @purchased_sessions.option
  end
end
