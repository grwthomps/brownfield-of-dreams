class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Turing Tutorials!')
  end

  def invite_email(user, current_user)
    @user = user
    @current_user_name = "#{current_user.first_name} #{current_user.last_name}"
    mail(to: user[:email], subject: "You've been invited to Turing Tutorials!")
  end
end
