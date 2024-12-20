class RoomsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :redirect_if_user_has_not_completed_profile
  before_action :redirect_if_the_trainer_has_not_been_approved
  before_action only: [:show] do
    redirect_if_user_cannot_access_session('root')
  end

  def show
    @session = _session
  end

  private

  def _session
    @session ||= Session.find_by!(room_id: params[:id])
  end
end