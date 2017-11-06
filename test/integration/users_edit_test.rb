require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
    	@user = users(:michael)
  	end

  test "edit with invalid information" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", password: "" } }
    assert_template 'users/edit'
    assert_select 'div .alert-danger', "The form contains 1 error."
    
  end
# edit template is rendered after getting the edit page and re-rendered upon submission of invalid information.

# Use an assert_select (Table 5.2) that tests for a div with class alert containing the text “The form contains 4 errors.( 1 error: allow_nil for password == true)”

test "update with valid information" do 
  log_in_as(@user)
	get edit_user_path(@user)
    assert_template 'users/edit'

    name  = "Lien"
    email = "lien@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
end
# we’ll submit valid information. Then we’ll check for a nonempty flash message and a successful redirect to the profile page, while also verifying that the user’s information correctly changed in the database.

test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert_not session[:forwarding_url]
    #make sure forwarding url is deleted after use
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end