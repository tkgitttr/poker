require 'test_helper'

class P0kerhandsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get p0kerhands_home_url
    assert_response :success
  end

end
