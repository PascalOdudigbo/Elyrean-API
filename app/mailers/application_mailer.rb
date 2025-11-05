class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_ADDRESS", "no-reply@elyrean.com")
  layout "mailer"
end
