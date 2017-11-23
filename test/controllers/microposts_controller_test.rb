require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

 def setup
    @micropost = microposts(:orange)
 end

test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

# We next write a short test to make sure one user can’t delete the microposts of a different user, and we also check for the proper redirect

test "should redirect destroy for non-owned micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end

end
