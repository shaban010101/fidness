class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.answers.empty?
      new_profile_path
    else
      trainers_path
    end
  end
end
