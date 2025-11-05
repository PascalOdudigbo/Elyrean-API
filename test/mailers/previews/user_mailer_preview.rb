# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def welcome_email
        user = User.first || User.new(username: "Test User", email: "test@example.com")# Fetch the first user from the database for preview
        UserMailer.welcome_email(user)
    end
end
