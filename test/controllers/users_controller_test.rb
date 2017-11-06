require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get sign_up_url
    assert_response :success
  end

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect edit attempt to login if user not logged in" do
  	get edit_user_path(@user)
  	assert_not flash.empty?
    assert_redirected_to login_url
  end
  # verify that the flash is set and that the user is redirected to the login path.

  test "should redirect update attemt to login if user not logged in" do
	patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit attempt to root if logged in as a different user" do
  	log_in_as(@other_user)
  	get edit_user_path(@user)
  	assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update attempt to root if logged in as a different user" do
  	log_in_as(@other_user)
  	patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
  	assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index to root if user not logged in" do
    get users_path
    assert_redirected_to login_url
  end



end
