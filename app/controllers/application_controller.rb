require 'net/http'
require 'uri'
require 'json'
class ApplicationController < ActionController::API
  before_action :authenticate

  def current_user
    @current_user
  end

  private
  def authenticate
    authorization_header = request.headers[:authorization]
    if !authorization_header
      render_unauthorized
    else
      token = authorization_header.split(" ")[1]
      Rails.logger.info("token: #{token}")
      secret_key = Rails.application.credentials.secret_key_base
      Rails.logger.info("secret_key: #{secret_key}")

      begin
        decoded_token = JWT.decode(token, secret_key)
        @current_user = User.find(decoded_token[0]["user_id"])
      rescue ActiveRecord::RecordNotFound
        render_unauthorized
      rescue JWT::DecodeError
        render_unauthorized
      end
    end
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
