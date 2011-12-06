require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get choose" do
    get :choose
    assert_response :success
  end

end
