# test/controllers/signup_controller_test.rb
require 'test_helper'
require 'pry'

class SignupControllerTest < ActionDispatch::IntegrationTest
  test "should create user with valid attributes" do
    post signup_url, params: { user: { name: 'testuser', last_name: 'testuser', email: 'testsign_up@example.com', password: 'password', password_confirmation: 'password' } }
    
    assert_response :created
    assert JSON.parse(response.body).key?('token')
  end

  test "should not create user with invalid attributes" do
    assert_no_difference('User.count') do
      post signup_url, params: { user: { name: '', last_name: '', email: 'testsign_up2@example.com', password: 'password', password_confirmation: 'password' } }
    end
    assert_response :unprocessable_entity
    assert JSON.parse(response.code).equal?(422)
  end
end
