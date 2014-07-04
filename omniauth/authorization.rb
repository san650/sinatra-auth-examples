require "sinatra"
require "omniauth"
require "omniauth/strategies/github"

class Authorizable < Sinatra::Base
  use Rack::Session::Cookie

  private

  set(:protected) do |_|
    condition do
      redirect to "/auth/github" unless authenticated?
    end
  end

  def authenticated?
    !!current_user
  end

  def authenticate!
    self.current_user = request.env["omniauth.auth"]["uid"]
  end

  def current_user=(user_id)
    session[:user_id] = user_id
  end

  def current_user
    session[:user_id]
  end
end

class GitHubAuthentication < Authorizable
  use OmniAuth::Builder do
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
  end

  get "/auth/:provider/callback" do
    authenticate!

    redirect to "/admin"
  end

  get "/auth/failure" do
    "Error!"
  end
end

class AppExample < GitHubAuthentication
  get "/" do
    erb '<p>Click <a href="<%= url("/admin") %>">here</a> to access to admin zone'
  end

  get "/admin", protected: true do
    "<h1>Private page</h1><p>Hello #{current_user}!"
  end

  run!
end
