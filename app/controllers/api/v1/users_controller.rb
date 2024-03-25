class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:guest_login]

  def create
    user = User.find_or_create_by(provider: params[:provider], uid: params[:uid], name: params[:name], email: params[:email])
    if user
      head :ok
    else
      render json: { error: "ログインに失敗しました" }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def guest_login
    User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end

    token = encode_jwt_token_for(user)
    render json: { token: token }
  end

  def encode_jwt_token_for(user)
    exp = 24.hours.from_now.to_i # 有効期限を24時間後に設定
    payload = { user_id: user.id, exp: exp }
    hmac_secret = ENV['JWT_SECRET_KEY']
    JWT.encode(payload, hmac_secret, 'HS256')
  end
end
