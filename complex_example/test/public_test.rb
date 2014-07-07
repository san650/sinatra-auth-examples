require "test_helper"
require "rack/test"
require "public"

class PublicTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Public
  end

  def html
    last_response.body
  end

  def test_index
    get "/"

    assert html.include?('<a href="http://example.org/admin">'), "Includes link to admin site"
  end
end
