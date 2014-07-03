require "sinatra"
require "omniauth"
require "omniauth/strategies/github"

class GithubApp < Sinatra::Base
  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
  end

  get "/" do
    "Hello World"
  end

  get "/private" do
    "<h1>Private page</h1><p>Hello #{session[:name]}!"
  end

  get "/auth/:provider/callback" do
    session[:name] = request.env["omniauth.auth"]["info"]["name"]

    redirect to("/private")
  end

  run!
end
