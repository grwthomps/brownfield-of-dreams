class UserInfoFacade
  def initialize(current_user)
    @current_user = current_user
  end

  def get_repos
    service = GithubService.new(@current_user)
    service.fetch_repos
  end

  def limit_five
    raw_repo_data = get_repos
    raw_repo_data[0..4].map do |data|
      Repo.new(data[:name], data[:html_url])
    end
  end

  def all_followers
    service = GithubService.new(@current_user)
    followers = service.fetch_followers
    followers.map do |follower|
      user = User.find_by(github_username: follower[:login])
      GithubUser.new(follower[:login], follower[:html_url], user)
    end
  end

  def following
    service = GithubService.new(@current_user)
    users = service.fetch_users
    users.map do |user|
      friend = User.find_by(github_username: user[:login])
      GithubUser.new(user[:login], user[:html_url], friend)
    end
  end

  def bookmarks
    @current_user.videos.joins(:tutorial).group('tutorials.id, videos.id').order('tutorials.id', 'videos.position')
  end
end
