class InviteController < ApplicationController
  def new; end

  def create
    invite = InviteFacade.new(current_user)
    user = invite.github_lookup(params[:github_handle])
    if user[:email] == nil
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      UserMailer.invite_email(user, current_user).deliver_now
      flash[:success] = "Successfully sent invite!"
    end
    redirect_to '/dashboard'
  end
end
