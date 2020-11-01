class TwilioController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :redirect_if_user_has_not_completed_profile

  def token
    account_sid = Rails.application.credentials.config.fetch(:twilio).fetch(:account_sid)
    api_key = Rails.application.credentials.config.fetch(:twilio).fetch(:sid)
    api_secret = Rails.application.credentials.config.fetch(:twilio).fetch(:secret)

    identity = "#{current_user.try(:first_name)}-#{current_user.try(:last_name)}"

    token = Twilio::JWT::AccessToken.new(account_sid,
                                         api_key,
                                         api_secret,
                                         ttl: 3600,
                                         identity: identity)


    grant = Twilio::JWT::AccessToken::VideoGrant.new
    session = Session.find_by!(room_id: token_params[:room_id])

    if allowed_to_access?(session)
      grant.room = session.room_id
      token.add_grant grant
      render(json: { token: token.to_jwt }, status: 200)
    else
      render(json: { error: 'Session does not exist' }, status: 404)
    end

  end

  def token_params
    params.permit(:room_id)
  end

  private

  def allowed_to_access?(session)
    session.purchased_session.user_id == current_user.id || session.purchased_session.trainer_id == current_user.id
  end
end