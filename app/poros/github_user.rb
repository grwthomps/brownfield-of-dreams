class GithubUser
  attr_reader :login, :html_url

  def initialize(login, html_url)
    @login = login
    @html_url = html_url
    @id = User.find_by(github_username: login).id
  end
end
