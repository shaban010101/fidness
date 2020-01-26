class ProfilesController < ApplicationController
  def new
    @questions = Question.where(user_type: current_user.type)
  end

  def create
    @questions = Question.where(user_type: current_user.type)
    @form = ProfileForm.new(current_user, profile_params)
  
    if @form.save
      if current_user.trainer?
        redirect_to :trainer_dashboard
      else
        redirect_to :trainers
      end  
    else
      flash[:errors] = @form.error_messages
      render 'new'
    end
  end

  def show; end

  private
  
  def profile_params
    params.permit(:first_name, :last_name, :avatar,
                  answers: [:answer, :question_id, :user_id],
                  profile: [:short_description, :long_description, :qualifications, :price])
  end
end
