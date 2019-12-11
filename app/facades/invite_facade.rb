class InviteFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def github_lookup(github_handle)
    service = GithubService.new(@current_user)
    email = service.find_github_user(github_handle)
  end
end
