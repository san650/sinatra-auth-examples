require "sinatra"

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'admin']
end

get "/" do
  "secret page"
end
