class ProfileForm
  include ActiveModel::Model

  attr_accessor :current_user, :first_name, :last_name, :avatar, :answers, :profile

  validates :first_name, :last_name, :avatar, :answers, :profile, presence: true
  validate :answers_valid?, :avatar_valid?, :profile_valid?

  def initialize(current_user, params = {})
    super(params)
    @current_user = current_user
  end

  def save
     return false if invalid?
     
     ActiveRecord::Base.transaction do
      current_user.tap do |user|
        user.first_name = first_name
        user.last_name = last_name
        user.avatar.attach(avatar) if avatar
        user.save
      end  
      
      answers.map { |answer| Answer.create(answer) }
      built_profile.save
    end
  end
  
  def error_messages
    (errors.full_messages + built_profile.errors.full_messages + @validated_answers)
  end
  
  private
  
  def answers_valid?
    @validated_answers = answers.flat_map do |answer|
      _answer = AnswerForm.new(answer)
      _answer.valid?
      _answer.errors.full_messages
    end

    @validated_answers.empty?
  end

  def profile_valid?
    built_profile.valid?
  end

  def built_profile
    @built_profile ||= current_user.build_profile(profile)
  end

  def avatar_valid?
    if current_user.type == 'Trainer'
      !avatar.blank?
    else
      true
    end
  end
end  
