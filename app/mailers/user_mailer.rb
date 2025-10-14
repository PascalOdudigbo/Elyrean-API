class UserMailer < ApplicationMailer
    default from: 'odudigbopascal@gmail.com'

    def welcome_email(user)
        @user = user # Make the @user instance variable available in the email templates
        @url  = 'http://elyrean.com/login' # Example URL for login/call to action

        mail(to: @user.email, subject: 'Welcome to Elyrean!')
    end
end
