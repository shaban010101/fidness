require 'stripe'

unless Rails.env == 'test'
  Stripe.api_key = Rails.application.credentials.config.fetch(:stripe).fetch(:api_key)
end
