class Admin < Protected

  before do
    redirect "/login" unless authenticated?
  end

  get "/" do
    "This is the admin site. Hello %s (%s)" % [
      Rack::Utils.escape_html(current_user.name),
      Rack::Utils.escape_html(current_user.provider)
    ]
  end

  get "/another" do
    "This is another admin page"
  end
end
