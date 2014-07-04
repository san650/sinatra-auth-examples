require "minitest/autorun"
require "rack/test"
require "protected"
require "admin"
require "user"

class AdminTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Admin
  end

  def test_index_redirects_to_login
    get "/"

    assert_equal "http://example.org/login", last_response["Location"], "redirects to login"
  end

  def test_another_redirects_to_login
    get "/another"

    assert_equal "http://example.org/login", last_response["Location"], "redirects to login"
  end

  def test_index_show_hello_message
    get "/", {}, "rack.session" => { user: User.new(1, "Santiago", "san650@gmail.com", :test) }

    assert last_response.body.include?("Santiago (test)")
  end
end
