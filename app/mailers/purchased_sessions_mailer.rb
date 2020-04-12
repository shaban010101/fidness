class PurchasedSessionsMailer < ApplicationMailer
  def purchased_sessions_email
    @purchased_session = params[:purchased_session]
    mail(to: @purchased_session.user.email, subject: 'Sessions purchased')
  end
end
