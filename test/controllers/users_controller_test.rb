require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

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

  test "invalid signup if email is already taken" do
    get new_user_path
    post users_path, params: { user: { first_name:  "name",
                                       last_name: "name",
                                       email: "michael@example.com",
                                       password: "password"} }
    assert_template 'new'
  end

end
