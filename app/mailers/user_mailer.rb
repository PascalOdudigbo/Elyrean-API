class UserMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_ADDRESS", "allmyprojectsemail@gmail.com")

  def welcome_email
    @user = params[:user]
    @user_token = params[:token]
    @app_name = params[:app_name] || "Elyrean"

    mail(to: @user.email, subject: "Welcome to #{@app_name}") do |format|
      format.html { render 'welcome_email' }  # uses welcome_email.html.erb
      format.text { render plain: "Hello #{@user.email}, welcome to #{@app_name}!" }
    end
  end

  def account_recovery_email
    @user = params[:user]
    @user_token = params[:token]
    @app_name = params[:app_name] || "Elyrean"

    def edit_password_reset_url(token:)
      "#{ENV.fetch("FRONTEND_URL")}/account-management/?token=#{@user_token}"
    end

    mail(to: @user.email, subject: "Password Reset Instructions for #{@app_name}") do |format|
      format.html { render 'account_recovery_email' }  # uses account_recovery_email.html.erb
      format.text { render plain: "Hello #{@user.email}, to reset your password, please use the following link: #{edit_password_reset_url(token: @user_token)}" }
    end
  end
end
