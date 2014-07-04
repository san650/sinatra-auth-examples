require "omniauth"
require "omniauth/strategies/github"

class Auth < Protected

  use OmniAuth::Builder do
    provider :developer, callback_path: "/login/auth/developer/callback"
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
  end

  get "/" do
    erb :login
  end

  get "/auth/github/callback" do
    self.current_user = User.new(
      request.env["omniauth.auth"]["uid"],
      request.env["omniauth.auth"]["info"]["name"],
      request.env["omniauth.auth"]["info"]["email"],
      :github
    )

    "You're authenticated with github! Go to the <a href=\"/admin\">admin</a>"
  end

  post "/auth/developer/callback" do
    self.current_user = User.new(
      params["email"],
      params["name"],
      params["email"],
      :developer
    )

    "You're authenticated with developer! Go to the <a href=\"/admin\">admin</a>"
  end

  get "/auth/failure" do
    "Error!"
  end
end
