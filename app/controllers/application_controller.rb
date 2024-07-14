class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JwtAuthentication.decode(header)
      @current_user = User.find(@decoded[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  # Private method to generate JWT token
  def generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end
end
