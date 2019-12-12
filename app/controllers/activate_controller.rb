class ActivateController < ApplicationController
  def show
    begin
      user = User.find(params[:id])
      user.update!(status: 'active')
      flash[:success] = "Thank you, your account is now activated."
    rescue
      flash[:error] = "Whoops, something went wrong. Please try to activate again."
    end
    redirect_to dashboard_path
  end
end
