class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_time_zone
  rescue_from ActiveRecord::RecordNotFound, with: -> { render_404  }

  protected

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  def after_sign_in_path_for(user)
     if user&.answers
       if user.trainer?
         trainer_dashboard_path
       else
         trainers_path
       end
     else
       new_profile_path
     end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :type, :terms_and_conditions_accepted])
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

  def redirect_if_user_has_not_completed_profile
    if current_user && current_user&.client?
      unless personal_details_completed? && answers?
        redirect_to_profile_page
      end
    else
      unless personal_details_completed? && answers? && current_user&.profile
        redirect_to_profile_page
      end
    end
  end

  def redirect_if_the_trainer_has_not_been_approved
    return if current_user.client?
    unless current_user&.profile && current_user&.profile&.approved
      flash[:error] = 'Your account is pending approval'
      redirect_to :new_profile
    end
  end

  private

  def personal_details_completed?
    !current_user&.first_name.nil? && !current_user&.last_name.nil?
  end

  def answers?
    current_user&.answers&.any?
  end

  def redirect_to_profile_page
    flash[:error] = 'Please complete your profile'
    redirect_to :new_profile
  end
end
