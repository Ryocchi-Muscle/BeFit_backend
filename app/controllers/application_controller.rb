class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

    def authenticate_user!
      token = request.headers['Authorization'].split.last
      payload = decode_jwt(token)
      @current_user = User.find_by(uid: payload['uid'])

      render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
    end

    def decode_jwt(token)
      JWT.decode(token, ENV['NEXTAUTH_SECRET'], true, { algorithm: 'HS256' }).first
    rescue JWT::DecodeError
      nil
    end
end
