class ApplicationMailer < ActionMailer::Base
  if Rails.env.production?
    default from: "noreply@#{ENV["MAILGUN_DOMAIN"]}"
  else
    default from: "noreply@example.com"
  end
  layout 'mailer'
end
