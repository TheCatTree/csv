require 'test_helper'

class EmberControllerTest < ActionController::TestCase
  test "should get bootstrap" do
    get :bootstrap
    assert_response :success
  end

end
