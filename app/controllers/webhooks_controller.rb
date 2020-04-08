# coding: utf-8
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create 
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret =  Rails.application.credentials.config.fetch(:stripe).fetch(:signing_secret)

    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      render status: 400, json: {}
    rescue Stripe::SignatureVerificationError => e
      render status: 400, json: {}
    end

    event_type = event['type']
    user = User.find_by_email_address(event['email'])

    if event_type == 'charge.succeeded'
      SessionsPurchasedMailer.with(user: user).purchased_email.deliver_later
    else
      
    end

    render status: 200, json: { status: 'success' }
  end
end
