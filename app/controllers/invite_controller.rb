class InviteController < ApplicationController
  def new
  end

  def create
    github_email = InviteFacade.new(current_user)
    if github_email.github_lookup(params[:github_handle]) == nil
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to '/dashboard'
    else
    UserMailer.with(user: @user).welcome_email.deliver_now

    redirect_to '/dashboard'
    flash[:success] = "Successfully sent invite!"
  end
end
