require File.expand_path("../classic.rb", __FILE__)

app = Rack::Auth::Digest::MD5.new(Sinatra::Application) do |username|
  { "foo" => "bar"}[username]
end

app.realm = "Protected Area"
app.opaque = "secertkey"

run app
