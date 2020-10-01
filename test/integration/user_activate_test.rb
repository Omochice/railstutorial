require "test_helper"

class UserActivateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @non_activated_user = users(:non_activated_user)
  end

  test "should not allow non activated attribute" do
    log_in_as @non_activated_user
    assert_not @non_activated_user.activated?

    get users_path
    assert_redirected_to login_url # 非有効化だとusersをみれない
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end
  test "should show activated user on users list" do
    log_in_as @user
    get users_path
    assert_select "a[href=?]", user_path(@user), count: 2
  end
end
