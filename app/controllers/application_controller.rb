class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

    def authenticate_request
      token = request.headers['Authorization']&.split(' ')&.last
      Rails.logger.info("authorization_header: #{token}")
      decoded_data = JsonWebToken.decode(token)
      Rails.logger.info("decoded_data: #{decoded_data}")
      @current_user = User.find_by(id: decoded_data[:user_id]) if decoded_data
      Rails.logger.info("current_user: #{@current_user}")
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
end
