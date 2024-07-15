class Api::V1::UsersController < ApplicationController
  before_action :set_current_user, only: [:destroy]
  def create
    # 引数の条件に該当するデータがあればそれを返す。なければ新規作成する
    user = User.find_or_create_by(user_params)
    if user
      head :ok
    else
      render json: { error: "ログインに失敗しました" }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
  def destroy
    user = User.find_by(uid: params[:uid])
    if user
      begin
        Rails.logger.debug("Attempting to destroy user: #{user.inspect}")
        user.destroy
        Rails.logger.debug("User destroyed successfully.")
        head :no_content
      rescue StandardError => e
        Rails.logger.error("Failed to destroy user: #{e.message}")
        render json: { error: "Failed to destroy user: #{e.message}" }, status: :internal_server_error
      end
    else
      render json: { error: "ユーザーが見つかりません" }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name)
  end
end
