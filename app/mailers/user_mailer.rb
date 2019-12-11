class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = "localhost:3000/users/#{@user.id}/activate"
    mail(to: @user.email, subject: 'Welcome to Turing Tutorials!')
  end
end
