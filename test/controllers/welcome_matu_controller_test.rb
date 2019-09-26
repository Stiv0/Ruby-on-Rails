require 'test_helper'

class WelcomeMatuControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_matu_index_url
    assert_response :success
  end

end
