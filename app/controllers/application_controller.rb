class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_time_zone
  rescue_from ActiveRecord::RecordNotFound, with: -> { render_404  }
  rescue_from StandardError, with: -> { render_500 }

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

  def redirect_if_user_cannot_access_session(path)
    unless current_user.id == _session.purchased_session.user.id || _session.purchased_session.trainer_id == current_user.id
      redirect_to path.to_sym
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html" , status: :not_found
  end

  def render_500
    render file: "#{Rails.root}/public/500.html" , status: :internal_server_error
  end
end
