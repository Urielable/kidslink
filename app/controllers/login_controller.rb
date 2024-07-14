# app/controllers/login_controller.rb
class LoginController < ApplicationController
  skip_before_action :authorize_request, only: :create
  
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: generate_token(user.id) }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
