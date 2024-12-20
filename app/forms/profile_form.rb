class ProfileForm
  include ActiveModel::Model

  attr_accessor :current_user, :first_name, :last_name, :avatar, :answers,
    :profile, :price, :short_description, :long_description, :qualifications

  validates :first_name, :last_name, :answers, presence: true
  validate :answers_valid?, :avatar_valid?, :profile_valid?

  def initialize(current_user, params = {})
    super(params)
    @current_user = current_user
  end

  def save
   return false if invalid?
   begin 
     ActiveRecord::Base.transaction do
       current_user.first_name = first_name
       current_user.last_name = last_name
       current_user.avatar.attach(avatar) if avatar
       current_user.save!
       
       Answer.create(answers)
       built_profile.save unless client?
       return true
     end
   rescue ActiveRecord::RecordInvalid => exception
     errors.add(:avatar, exception.message)
     return false
   end
  end
  
  def error_messages
    @error_messages = errors.full_messages
    @error_messages += built_profile.errors.full_messages unless client?
    @error_messages += @validated_answers
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
    return true if client?
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

  def client?
    current_user.type == 'Client'
  end
end  
