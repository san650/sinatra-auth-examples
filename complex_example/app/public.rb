require "sinatra/base"

class Public < Sinatra::Base
  enable :inline_templates

  get "/" do
    erb :index
  end
end

__END__

@@ index
<h1>Complex example</h1>
<p>
  To access the admin site click
  <a href="<%= url("/admin") %>">here</a>.
