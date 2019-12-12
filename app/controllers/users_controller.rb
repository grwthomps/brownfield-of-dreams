class UsersController < ApplicationController
  def show
    @client_id = ENV['github_client_id']
    render locals: {
    user_info: UserInfoFacade.new(current_user),
    user_name: "#{current_user.first_name} #{current_user.last_name}",
    user_email: current_user.email,
    user_status: current_user.status,
    user_token: current_user.github_token
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.first_name}."
      flash[:success] = "This account has not yet been activated. Please check your email."
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end
