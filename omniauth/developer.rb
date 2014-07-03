require "sinatra"
require "omniauth"

class DeveloperExample < Sinatra::Base
  use Rack::Session::Cookie
  use OmniAuth::Strategies::Developer

  get "/" do
    "Hello World"
  end

  get "/private" do
    "<h1>Private page</h1><p>Hello #{session[:uid]}!"
  end

  post "/auth/:provider/callback" do
    session[:uid] = request.env["omniauth.auth"]["uid"]

    redirect to("/private")
  end

  run!
end
