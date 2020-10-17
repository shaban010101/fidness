class RoomsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action only: [:show] do
    redirect_if_user_cannot_access_session('root')
  end

  def show
    @session = session
  end

  private

  def session
    @session ||= Session.find_by!(room_id: params[:id])
  end
end