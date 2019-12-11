class ActivateController < ApplicationController
  def show
    user = User.find(params[:id])
    user.update!(status: 'active')
    if user.save
      flash[:success] = "Thank you, your account is now activated."
    else
      flash[:error] = "Whoops, something went wrong. Please try to activate again."
    end
    redirect_to dashboard_path
  end
end
