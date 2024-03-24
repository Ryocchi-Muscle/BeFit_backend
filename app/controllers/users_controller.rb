class UserController < ApplicationController
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     render json: { status: 'User created successfully' }, status: :created
  #   else
  #     render json: { errors: user.errors.full_messages }, status: :bad_request
  #   end
  # end

  # private

  #   def user_params
  #     params.require(:user).permit(:email, :password, :password_confirmation)
  #   end

  skip_before_action :verify_authenticity_token, only: [:guest_login]

  def guest_login
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end

    token = encode_jwt_token_for(new_user)
    render json: { token: token }
  end

  def encode_jwt_token_for(user)

  end
end
