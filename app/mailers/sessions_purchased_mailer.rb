class SessionsPurchasedMailer < ApplicationMailer
  def purchased_email
    mail(to: user.email, subject: 'Sessions purchased')
  end
end
