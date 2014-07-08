require "test_helper"
require "rack/test"
require "auth"

class AuthTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Auth
  end

  def test_index_show_list_of_providers
    get "/"

    assert_contain last_response.body, '<a href="http://example.org/auth/developer">Developer'
    assert_contain last_response.body, '<a href="http://example.org/auth/github">Github'
    assert_contain last_response.body, '<a href="http://example.org/auth/facebook">Facebook'
    assert_contain last_response.body, '<a href="http://example.org/auth/twitter">Twitter'
    assert_contain last_response.body, '<a href="http://example.org/auth/google_oauth2">Google'
  end

  %w[github facebook twitter google_oauth2].each do |provider|
    define_method("test_login_with_#{provider}") do
      assert_provider(provider)
    end
  end

  private

  def assert_contain(expected, actual)
    assert expected.include?(actual), "Expected:\n#{expected}\nTo include:\n#{actual}"
  end

  def assert_provider(provider)
    OmniAuth.config.test_mode = true

    get "/auth/#{provider}"
    follow_redirect!

    assert_equal last_response.body, "You're authenticated with #{provider}! Go to the <a href=\"/admin\">admin</a>"
  end
end
