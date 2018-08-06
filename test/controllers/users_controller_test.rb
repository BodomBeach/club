require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  # def setup
  #   @user = User.create(first_name: "Michel", last_name: "Sardou", email: "michel@yahoo.com")
  # end

  test "should get home" do
    get '/'
    assert_response :success
  end

  test "invalid signup if no first_name" do
    get new_user_path
    post users_path, params: { user: { first_name:  "",
                                       last_name: "name",
                                       email: "user@example.com",
                                       password: "password"} }
    assert_template 'new'
  end

  test "invalid signup if no last_name" do
    get new_user_path
    post users_path, params: { user: { first_name:  "name",
                                       last_name: "",
                                       email: "user@example.com",
                                       password: "password"} }
    assert_template 'new'
  end

  test "invalid signup if no email" do
    get new_user_path
    post users_path, params: { user: { first_name:  "name",
                                       last_name: "name",
                                       email: "",
                                       password: "password"} }
    assert_template 'new'
  end

  test "invalid signup if email is taken" do
    get new_user_path
    post users_path, params: { user: { first_name:  "name",
                                       last_name: "name",
                                       email: "michael@example.com",
                                       password: "password"} }
    assert_template 'new'
  end

  # test "should have club link if logged_in" do
  #   session.https!
  #   get '/'
  #   assert_select '.btn', "Accès au club"
  # end


  # test "should get new" do
  #   get new_user_path
  #   assert_response :success
  # end
  #
  # test "should get create" do
  #   post '/users'
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get users_show_url
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get users_edit_url
  #   assert_response :success
  # end
  #
  # test "should get update" do
  #   get users_update_url
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get users_destroy_url
  #   assert_response :success
  # end

end
