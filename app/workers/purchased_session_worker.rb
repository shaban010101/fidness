class PurchasedSessionWorker
  include Sidekiq::Worker

  def perform(event)
     payment_intent_id = event['data']['object']['payment_intent']
     payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)

    if event['type'] == 'charge.succeeded' 
      purchased_session = PurchasedSession.new(
        option_id: payment_intent[:metadata][:option_id], 
        trainer_id: payment_intent[:metadata][:trainer_id], 
        user_id: payment_intent[:metadata][:user_id])
    
      purchased_session.save
      availability = Availability.exists?(available_at: DateTime.parse(payment_intent[:metadata][:session_at]))

      if availability
        Session.create(
          purchased_session_id: purchased_session.id, 
          session_at: payment_intent[:metadata][:session_at]
        )
      end  
 
      PurchasedSessionsMailer.with(purchased_session: purchased_session).purchased_sessions_email.deliver_later
    end
  end
end
