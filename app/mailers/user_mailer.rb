class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = "https://shrouded-island-82497.herokuapp.com/users/#{@user.id}/activate"
    mail(to: @user.email, subject: 'Welcome to Turing Tutorials!')
  end
end
