require 'net/http'
require 'uri'
require 'json'

# ApplicationController
class ApplicationController < ActionController::API
  include ActionController::Cookies

  attr_reader :current_user

  private

    def set_current_user
      received_access_token = request.headers["Authorization"]&.split&.last
      # Rails.logger.debug("received_access_token: #{received_access_token}")

      if session[:user_id] && session[:access_token] == received_access_token
        # セッションからユーザー情報を取得
        @current_user = User.find_by(id: session[:user_id])
      else
        # 既存のセッション情報をクリア
        session.delete(:user_id)
        session.delete(:access_token)

        # Google APIからユーザー情報を取得
        Rails.logger.debug("received_access_token: #{received_access_token}")
        user_info = fetch_user_info_from_google(received_access_token)
        Rails.logger.debug("user_info: #{user_info}")

        # Googleの 'sub'（ユーザーID）をもとにユーザー検索
        @current_user = User.find_by(uid: user_info['sub'])

        if @current_user
          # セッションにユーザー情報を保存
          session[:user_id] = @current_user.id
          session[:access_token] = received_access_token
        else
          # ユーザーが見つからない場合の処理（エラーレスポンスなど）
          render json: { error: 'User not found' }, status: :not_found
        end
      end
    end

  # Googleのユーザー情報を取得
    def fetch_user_info_from_google(access_token)
      Rails.logger.debug("access_token: #{access_token}")
      uri = URI.parse("https://www.googleapis.com/oauth2/v3/userinfo")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{access_token}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end

      # レスポンスがエラーを含むかどうかを確認
      if response.code != '200'
        Rails.logger.error("Google API Error: #{response.body}")
        # エラーレスポンスをJSON形式で解析
        error_response = JSON.parse(response.body)
        Rails.logger.error("Error details: #{error_response['error']}, Description: #{error_response['error_description']}")
      end

      JSON.parse(response.body)
    rescue JSON::ParserError => e
      Rails.logger.error("JSON Parsing Error: #{e.message}")
      # パースに失敗した場合は空のハッシュを返す
      {}
    end
end
