require "sinatra/base"

class Protected < Sinatra::Base

  use Rack::Session::Cookie, secret: ENV["COOKIE_SECRET"]

  private

  def authenticated?
    !!current_user
  end

  def current_user=(user)
    session[:user] = user
  end

  def current_user
    session[:user]
  end
end
