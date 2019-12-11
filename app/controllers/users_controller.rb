class UsersController < ApplicationController
  def show
    @client_id = ENV['github_client_id']
    if current_user.github_token
      render locals: {
      user_repos: UserInfoFacade.new(current_user),
      user_info: UserInfoFacade.new(current_user),
      }
    end
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
