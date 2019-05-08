class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(user)
     if user.answers.answers
       if user.trainer?
         redirect_to :trainer_dashboard
       else
         redirect_to :trainers
       end
     else
       redirect_to :new_profile_path
     end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :type])
  end
end
