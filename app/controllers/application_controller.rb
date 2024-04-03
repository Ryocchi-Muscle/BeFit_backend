class ApplicationController < ActionController::API
  # before_action :authenticate_user!

  # private

  #   def authenticate_user!
  #     authorization_header = request.headers['Authorization']

  #     if authorization_header.present?
  #       token = authorization_header.split.last
  #       payload = decode_jwt(token)
  #       @current_user = User.find_by(id: payload['uid'])

  #       unless @current_user
  #         render json: { error: 'Not Authorized' }, status: :unauthorized
  #       end
  #     else
  #       render json: { error: 'Authorization token missing' }, status: :unauthorized
  #     end
  #   end

  #   def decode_jwt(token)
  #     JWT.decode(token, ENV['NEXTAUTH_SECRET'], true, { algorithm: 'HS256' }).first
  #   rescue JWT::DecodeError
  #     nil
  #   end
end
