class GithubUser
  attr_reader :login, :html_url, :id

  def initialize(login, html_url, user = nil)
    @login = login
    @html_url = html_url
    @id = user ? user.id : nil
  end
end
