require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index,{:user_id=>1}
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should get new" do
    login_as(:valid_user)
    get :new,{:user_id=>1}
    assert_response :success
  end

  test "should create entry" do
    login_as(:valid_user)
    assert_difference('Entry.count') do
      post :create, :entry => {:title=>'test entry',:body=>'a blog entrry' }
    end
    
    assert_redirected_to user_entry_path(assigns(:entry))
  end

  test "should show entry" do
    get :show, :id => entries(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => entries(:one).id
    assert_response :success
  end

  test "should update entry" do
    put :update, :id => entries(:one).id, :entry => { }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy entry" do
    assert_difference('Entry.count', -1) do
      delete :destroy, :id => entries(:one).id
    end

    assert_redirected_to entries_path
  end
end
