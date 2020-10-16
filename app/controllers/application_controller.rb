class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_time_zone

  protected

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  def after_sign_in_path_for(user)
     if user&.answers
       if user.trainer?
         redirect_to :trainer_dashboard && return
       else
         redirect_to :trainers && return
       end
     else
       redirect_to :new_profile_path && return
     end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :type])
  end

  def redirect_if_not_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end

  def redirect_if_not_trainer
    unless current_user.trainer?
      redirect_to trainers_path
    end
  end
end
