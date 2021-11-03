class UserMailer < ApplicationMailer
  default from: 'nikob381@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
