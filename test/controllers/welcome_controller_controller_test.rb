require 'test_helper'

class WelcomeControllerControllerTest < ActionDispatch::IntegrationTest
  test "welcome page" do
    get root_url
    assert_response :success
  end
end
