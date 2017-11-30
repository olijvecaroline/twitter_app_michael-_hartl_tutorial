require 'test_helper'

# we visit the user profile page and check for the page title and the user’s name, Gravatar, micropost count, and paginated microposts

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:michael)
	end

	test "profile display" do
	    get user_path(@user)
	    assert_template 'users/show'
	    assert_select 'title', full_title(@user.name)
	    assert_select 'h1', text: @user.name
	    assert_select 'h1>img.gravatar'
	    assert_match @user.microposts.count.to_s, response.body
	    assert_match @user.following.count.to_s, response.body
	    assert_match @user.followers.count.to_s, response.body
	    assert_select 'div.pagination'
	    @user.microposts.paginate(page: 1).each do |micropost|
	      assert_match micropost.content, response.body
    end
  end


end
