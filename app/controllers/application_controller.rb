class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

    def authenticate_request
      header = request.headers['Authorization']
      Rails.logger.info("FULL: #{header}")
      header = header.split(' ').last if header
      Rails.logger.info("authorization_header: #{header}")
      begin
        @decode = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
end
