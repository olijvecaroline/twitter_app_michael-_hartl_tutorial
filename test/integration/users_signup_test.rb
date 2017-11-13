require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
	
	
   test "invalid signup information" do
   	 get sign_up_path

   	 
     assert_no_difference'User.count' do 
     	post sign_up_path, params: { user: { name:  "",
                                     	   email: "user@invalid",
                                     	   password:              "foo",
                                     	   password_confirmation: "bar" } }
     end

     assert_template 'users/new'
     assert_select 'div #error_explanation'
	 assert_select 'div .alert'     
   end

test "valid signup information" do
   	 get sign_up_path
   	 
   	 
     assert_difference 'User.count',1 do 
     	post sign_up_path, params: { user: { name:  "name",
                                     	   email: "user@valid.com",
                                     	   password:              "foobar1",
                                     	   password_confirmation: "foobar1" } }
     end
    #  follow_redirect!
    #  assert_template 'users/show'
	   # assert_select 'div .alert-success' 
	   # assert_not flash.empty?    
    #  assert is_logged_in?
     
   end

   
end
