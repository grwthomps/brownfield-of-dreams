class GithubController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    current_user.update!(:github_token => user_info[:credentials][:token],
                         :github_username => user_info[:extra][:raw_info][:login])
    redirect_to dashboard_path
  end
end
