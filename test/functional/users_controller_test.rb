require 'test_helper'
#require 'users_controller'
class UsersControllerTest < ActionController::TestCase
#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:users)
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create user" do
#    assert_difference('User.count') do
#      post :create, :user => { }
#    end
#
#    assert_redirected_to user_path(assigns(:user))
#  end
#
#  test "should show user" do
#    get :show, :id => users(:one).id
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => users(:one).id
#    assert_response :success
#  end
#
#  test "should update user" do
#    put :update, :id => users(:one).id, :user => { }
#    assert_redirected_to user_path(assigns(:user))
#  end
#
#  test "should destroy user" do
#    assert_difference('User.count', -1) do
#      delete :destroy, :id => users(:one).id
#    end
#
#    assert_redirected_to users_path
#  end
  test "setup" do
    @controller=UsersController.new
    @request=ActionController::TestRequest.new
    @response=ActionController::TestResponse.new
  end
  test "test_signup_page" do
    get :new
    assert_response :success
  end
  test "test_valid_signup_and_redirect" do
    post :create,:user=>{:username=>'fred',:email=>'fred@example.com',:password=>'abc123',:password_confirmation=>'abc123',:profile=>'A regular guy'}
    assert_response :redirect
  end
  test "test_invalid_signup_dupe_username" do
    post :create,:user=>{:username=>'joe',:email=>'fred@example.com',:password=>'abc123',:password_confirmation=>'abc123',:profile=>'A regular guy'}
    assert assigns(:user).errors.on(:username)
    assert_response :success
    assert_template 'users/new'
  end
end
