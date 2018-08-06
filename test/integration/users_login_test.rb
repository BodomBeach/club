require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "right link if logged in" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      assert_redirected_to root_path
      follow_redirect!
      assert_select '.btn', "Accès au club"
  end

  test "get error message if wrong password" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'wrong_password' } }
      assert_template 'new'
      assert_not flash.empty?
  end

  test "navbar: right link if logged in" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      assert_redirected_to root_path
      follow_redirect!
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", users_path
      assert_select "a[href=?]", login_path, count: 0
  end

  test "navbar: right link if NOT logged in" do
      get '/'
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", new_user_path
  end

  test "no access to club if not logged in" do
      get users_path
      assert_response :redirect
      assert_redirected_to login_path
  end

  test "access to club if logged in" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      get users_path
      assert_response :success
  end

  test "club page shows all users" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      get users_path
      assert_select 'tr', User.all.count + 1
      #asserts that index table contains the right number lines (=number of users)
  end

end
