# app/controllers/signup_controller.rb
class SignupController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.new(user_params)
    if user.save
      render json: { token: generate_token(user.id) }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
  end
end
