require "test_helper"
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

  def test_index_shows_hello_message
    get "/", {}, logged_user_session

    assert last_response.body.include?("Santiago (test)")
  end

  def test_another_shows_message
    get "/another", {}, logged_user_session

    assert_equal last_response.body, "This is another admin page"
  end

  private

  def logged_user_session
    {
      "rack.session" => {
        user: User.new(1, "Santiago", "santiago.ferreira@wyeworks.com", :test)
      }
    }
  end
end
