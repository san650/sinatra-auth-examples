require "sinatra/base"

class Private < Sinatra::Base

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'foo' && password == 'bar'
  end

  get "/" do
    "secret"
  end

  get "/another" do
    "another secret"
  end
end

class Public < Sinatra::Base
  get "/" do
    "public"
  end
end
