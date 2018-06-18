require 'test_helper'

class P0kerhandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get p0kerhands_home_url
    assert_response :success
  end

end
