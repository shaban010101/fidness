class TrainerDashboardsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :redirect_if_user_has_not_completed_profile
  before_action :redirect_if_not_trainer

  def show
    @sessions = Session.future_sessions(current_user.id)
  end
end
