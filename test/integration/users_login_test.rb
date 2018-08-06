require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:michael)
    @user2 = users(:notmichael)
  end

  test "right link if logged in" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_select '.btn', "Accès au club"
  end

  test "get error message if wrong password" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'wrong_password' } }
    assert_template 'new'
    assert_not flash.empty?
  end

  test "navbar: right link if logged in" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
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
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    get users_path
    assert_response :success
  end

  test "club page shows all users" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    get users_path
    assert_select 'tr', User.all.count + 1
    #asserts that index table contains the right number lines (=number of users)
  end

    ######################   BEGINNING OF TDD   ########################

  test "navbar: show link visible if logged in" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", user_path(@user1.id)
  end

  test "navbar: show link NOT visible if NOT logged in" do
    get ''
    assert_select "a[href=?]", user_path(@user1.id) , count: 0
  end


  test "show page displays user info" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    assert_redirected_to root_path
    get user_path id: @user1.id
    assert_select 'p', 'Michael'
  end

  test "show page available if logged in" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    get user_path id: @user1.id
    assert_response :success
  end

  test "show page unavailable if NOT logged in" do
    get user_path id: @user1.id
    assert_redirected_to login_path
  end

  test "show page unavailable if not the right person" do
    get login_path
    post login_path, params: { session: { email: @user1.email, password: 'password' } }
    get user_path id: @user2.id
    assert_redirected_to '/'
    assert_not flash.empty?
  end

end
