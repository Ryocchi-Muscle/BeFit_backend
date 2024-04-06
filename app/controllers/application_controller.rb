class ApplicationController < ActionController::API
#   before_action :authenticate_user!

#   private

#     def authenticate_user!
#       authorization_header = request.headers['Authorization']
# pp request.headers['Authorization']
#       if authorization_header.present?
#         Rails.logger.info("authorization_header: #{authorization_header}")
#         token = authorization_header.split.last
#         payload = decode_jwt(token)
#          Rails.logger.info("payload: #{payload}")
#         @current_user = User.find_by(id: payload['uid'])
#         Rails.logger.info("current_user: #{@current_user}")

#         unless @current_user
#           render json: { error: 'Not Authorized' }, status: :unauthorized
#         end
#       else
#         render json: { error: 'Authorization token missing' }, status: :unauthorized
#       end
#     end

#     def decode_jwt(token)
#       decoded =  JWT.decode(token, ENV['NEXTAUTH_SECRET'], true, { algorithm: 'HS256' }).first
#       Rails.logger.debug "Decoded JWT: #{decoded}"
#     rescue JWT::DecodeError => e
#       Rails.logger.error "JWT Decode Error: #{e.message}"
#       nil
#     end
end
