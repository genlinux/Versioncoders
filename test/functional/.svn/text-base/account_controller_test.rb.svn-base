require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  fixtures :users
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "setup" do
    @controller=AccountController.new
    @request=ActionController::TestRequest.new
    @response=ActionController::TestResponse.new
  end
  test "valid_login_and_redirect" do
    post :authenticate,:user=> {:username=>'arasu',:password=>'arasu'}
    assert session[:user]
    assert_response :redirect
  end
  test "invalid_login" do
    post :authenticate,:user=> {:username=>'arasu',:password=>'joe'}
    assert !session[:user]
    assert_response :redirect
    assert_redirected_to :action=>'login'
    assert flash.has_key?(:error)
  end
  test "logout" do
    post :authenticate,:user=> {:username=>"arasu",:password=>"arasu"}
    assert session[:user]
    post :logout
    assert !session[:user]
    assert_response :redirect
  end
end
