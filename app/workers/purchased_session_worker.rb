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
      session_at = DateTime.parse(payment_intent[:metadata][:session_at])
      unavailable_times = Availability.joins(:session).where(available_at: session_at)
      availability = Availability.where(available_at: session_at).where.not(id: unavailable_times).first

      if availability
        Session.create(
          purchased_session_id: purchased_session.id, 
          availability_id: availability.id
        )
      end  
 
      PurchasedSessionsMailer.with(purchased_session: purchased_session).purchased_sessions_email.deliver_later
    end
  end
end
