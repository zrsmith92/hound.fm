require 'test_helper'

class ArtistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get tracks" do
    get :tracks
    assert_response :success
  end

  test "should get events" do
    get :events
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get videos" do
    get :videos
    assert_response :success
  end

  test "should get similar" do
    get :similar
    assert_response :success
  end

end
