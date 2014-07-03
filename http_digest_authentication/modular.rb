require "sinatra/base"

class Private < Sinatra::Base

  get "/" do
    "secret"
  end

  get "/another" do
    "another secret"
  end

  def self.new(*)
    app = Rack::Auth::Digest::MD5.new(super) do |username|
      { "foo" => "bar" }[username]
    end

    app.realm = "Protected Area"
    app.opaque = "secretkey"

    app
  end
end

class Public < Sinatra::Base

  get "/" do
    "public"
  end

end
