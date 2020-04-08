class TrainerDashboardsController < ApplicationController
  before_action :redirect_if_not_trainer
  def show
    @sessions = Session.future_sessions(current_user.id)
  end

  private 

  def redirect_if_not_trainer
    unless current_user.trainer?
      redirect_to trainers_path
    end
  end 
end
