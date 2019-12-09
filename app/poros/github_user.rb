class GithubUser
  attr_reader :login, :html_url, :id

  def initialize(login, html_url)
    @login = login
    @html_url = html_url
    @id = assign_id
  end

  def assign_id
    if User.find_by(github_username: @login) != nil
      @id = User.find_by(github_username: @login).id
    else
      @id = nil
    end
  end
end
