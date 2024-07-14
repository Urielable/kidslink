# test/controllers/login_controller_test.rb
require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  # Load fixtures
  fixtures :users

  setup do
    @user = users(:one)
  end

  test "should login with valid credentials" do
    post login_url, params: { email: @user.email, password: 'password' }
    assert_response :success
    assert JSON.parse(response.body).key?('token')
  end

  test "should not login with invalid credentials" do
    post login_url, params: { email: @user.email, password: 'wrongpassword' }
    assert_response :unauthorized
    assert JSON.parse(response.code).equal?(401)
  end
end
