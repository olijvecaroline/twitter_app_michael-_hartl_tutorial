require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	def setup
		@user=users(:michael)
	end

	test "should get index page" do
		log_in_as(@user)
		get users_path
		assert_template 'users/index'
		assert_select 'div.pagination', count: 2
		User.paginate(page: 1).each do |user|
      		assert_select 'a[href=?]', user_path(user), text: user.name
    	end
	end
end

#The idea is to log in, visit the index path, verify the first page of users is present, and then confirm that pagination is present on the page. 