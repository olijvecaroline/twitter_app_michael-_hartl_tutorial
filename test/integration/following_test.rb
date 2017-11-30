require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

 def setup
    @user = users(:michael)
    log_in_as(@user)
    @other = users(:archer)
  end

  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "follow" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
  end

  test "follow with ajax" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other.id }, xhr: true
    end
  end
  
end
